<?php 
ob_start();
session_start();
include ("../_init.php");

// Redirect, If user is not logged in
if (!is_loggedin()) {
  redirect(root_url().'index.php?redirect_to=' . url());
}

// Redirect, If User has not Read Permission
if (user_group_id() != 1 && !has_permission('access', 'barcode_print')) {
  redirect(root_url().ADMINDIRNAME.'/dashboard.php');
}

// Handle URL parameter for automatic product loading
$auto_product = null;
if (isset($request->get['p_code']) && !empty($request->get['p_code'])) {
  $p_code = $request->get['p_code'];
  
  $statement = $db->prepare("
    SELECT p.p_id, p.p_name, p.p_code, p.barcode_symbology, p2s.sell_price, p2s.quantity_in_stock, p.unit_id, p.category_id,
           u.unit_name, c.category_name
    FROM `products` p 
    LEFT JOIN `product_to_store` p2s ON (p.p_id = p2s.product_id AND p2s.store_id = ? AND p2s.status = 1)
    LEFT JOIN `units` u ON p.unit_id = u.unit_id 
    LEFT JOIN `categorys` c ON p.category_id = c.category_id 
    WHERE p.p_code = ? 
    LIMIT 1
  ");
  
  $statement->execute(array(store_id(), $p_code));
  $auto_product = $statement->fetch(PDO::FETCH_ASSOC);
  
  if ($auto_product && $auto_product['p_id']) {
    // Calculate default quantity (available_qty/2, minimum 1)
    $default_qty = max(1, floor($auto_product['quantity_in_stock'] / 2));
    $auto_product['default_quantity'] = $default_qty;
  }
}

// Set Document Title
$document->setTitle(trans('title_barcode'));

// Add Style
$document->addStyle('../assets/itsolution24/css/barcode.css', 'stylesheet', 'all');
$document->addStyle('../barcode.css', 'stylesheet', 'all');

// ADD BODY CLASS
$document->setBodyClass('sidebar-collapse');

// Include Header and Footer
include("header.php"); 
include ("left_sidebar.php") ;
?>

<!-- Content Wrapper Start -->
<div class="content-wrapper">

  <!-- Content Header Start -->
  <section class="content-header">
    <h1>
      <?php echo trans('text_barcode_title'); ?>
      <small>
        <?php echo store('name'); ?>
      </small>
    </h1>
    <ol class="breadcrumb">
      <li>
        <a href="dashboard.php">
          <i class="fa fa-dashboard"></i> 
          <?php echo trans('text_dashboard'); ?>
        </a>
      </li>
      <li class="active">
          <?php echo trans('text_barcode_title'); ?>  
      </li>
    </ol>
  </section>
  <!-- Content Header End -->

  <!-- Content Start -->
  <section class="content">
    <div class="row">
      <div class="col-xs-12">
        <div class="box box-success">
          <div class="box-header">
            <h3 class="box-title">
              <?php echo trans('text_barcode_title'); ?>
            </h3>
            <div class="box-tools pull-right">
              <button type="button" class="btn btn-box-tool" data-widget="collapse">
                <i class="fa fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="box-body">
            <form id="form-barcode-generate" class="form-horizontal" method="post">
              
              <!-- Product Selection -->
              <div class="well well-sm">
                <div class="well well-sm bg-gray r-50">
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Product</label>
                        <div class="col-sm-9">
                          <input type="text" id="product_search" class="form-control" placeholder="Search products..." autocomplete="off">
                          <div id="product_suggestions" class="dropdown-menu" style="display: none; width: 100%; max-height: 200px; overflow-y: auto;"></div>
                        </div>
                      </div>
                      </div>
                    </div>  
                  </div> 
                </div> 

              <!-- Selected Products Table -->
                    <div class="table-responsive">
                <table class="table table-bordered table-striped" id="product-table">
                        <thead>
                    <tr class="bg-gray">
                      <th class="text-center">Product Name</th>
                      <th class="text-center">Quantity</th>
                      <th class="text-center">Action</th>
                          </tr>
                        </thead>
                        <tbody>
                    <tr class="noproduct">
                      <td colspan="3" class="text-center text-muted">
                        No products selected
                              </td>
                            </tr>
                        </tbody>
                      </table>
              </div>

              <!-- Barcode Settings -->
              <div class="well well-sm">
                <h4>Barcode Settings</h4>
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="col-sm-4 control-label">Per Page</label>
                      <div class="col-sm-8">
                        <select name="per_page" class="form-control" id="per_page">
                          <option value="40">40 per sheet (a4) (1.799" x 1.003")</option>
                          <option value="30">30 per sheet (2.625" x 1")</option>
                          <option value="24">24 per sheet (a4) (2.48" x 1.334")</option>
                          <option value="20">20 per sheet (4" x 1")</option>
                          <option value="18">18 per sheet (a4) (2.5" x 1.835")</option>
                          <option value="14">14 per sheet (4" x 1.33")</option>
                          <option value="12">12 per sheet (a4) (2.5" x 2.834")</option>
                          <option value="10">10 per sheet (4" x 2")</option>
                          <option value="retsol">Retsol (10cm x 2.2cm - 2 columns)</option>
                          <option value="tsc" selected>TSC (8cm x 2.5cm - 2 columns)</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="col-sm-4 control-label">Available Qty</label>
                      <div class="col-sm-8">
                        <div id="available-qty-display" class="form-control-static text-info">
                          <i class="fa fa-info-circle"></i> Select a product to see available quantity
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                
                <!-- Field Options -->
                <div class="row">
                  <div class="col-md-12">
                    <div class="form-group">
                      <label class="col-sm-3 control-label">Fields to Display</label>
                      <div class="col-sm-9">
                        <div class="checkbox">
                          <label><input type="checkbox" name="fields[site_name]" value="1" checked> Site name</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[product_name]" value="1" checked> Product name</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[p_code]" value="1" checked> Product code</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[price]" value="1" checked> Price</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[currency]" value="1"> Currency</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[unit]" value="1"> Unit</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[category]" value="1"> Category</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[product_image]" value="1"> Product Image</label>
                        </div>
                        </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Action Buttons -->
                <div class="form-group">
                <div class="col-sm-12 text-center">
                  <button type="button" id="generate_barcodes" class="btn btn-primary btn-lg">
                    <i class="fa fa-barcode"></i> Generate Barcodes
                  </button>
                  <button type="button" id="print_barcodes" class="btn btn-success btn-lg" style="display: none;">
                    <i class="fa fa-print"></i> Print Barcodes
                    </button>
                  <a href="barcode_print.php" class="btn btn-danger btn-lg">
                    <i class="fa fa-refresh"></i> Reset
                  </a>
                </div>
              </div>
            </form>

            <!-- Barcode Display Area -->
            <div id="barcode-display" style="display: none;">
              <div class="well well-sm">
                <h4>Generated Barcodes</h4>
                <div id="barcode-container"></div>
                <div class="text-center" id="print-buttons" style="margin-top: 20px;">
                  <div class="btn-group">
                    <button class="btn btn-lg btn-primary" onClick="printBarcodes();"><span class="fa fa-print"></span> Print Barcodes</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<!-- Include JsBarcode CDN -->
<script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>

<script>
$(document).ready(function() {
    let selectedProducts = [];
    
    // Define functions first
    function addProductToTable(product) {
        console.log('addProductToTable called with:', product);
        
        // Map PHP object properties to JavaScript object properties
        const mappedProduct = {
            id: product.p_id || product.id,
            name: product.p_name || product.name,
            code: product.p_code || product.code,
            sell_price: product.sell_price,
            unit: product.unit_name || product.unit,
            category: product.category_name || product.category,
            quantity_in_stock: product.quantity_in_stock,
            barcode_symbology: product.barcode_symbology,
            quantity: product.default_quantity || product.quantity || 1
        };
        
        console.log('Mapped product:', mappedProduct);
        
        // Check if product already added
        if (selectedProducts.find(p => p.id === mappedProduct.id)) {
            alert('Product already added!');
            return;
        }
        
        selectedProducts.push(mappedProduct);
        console.log('Updated selectedProducts:', selectedProducts);
        updateProductTable();
        
        // Update available quantity display
        $('#available-qty-display').html('<i class="fa fa-check-circle text-success"></i> Available: ' + mappedProduct.quantity_in_stock + ' units');
    }
    
    function updateProductTable() {
        console.log('updateProductTable called with selectedProducts:', selectedProducts);
        let html = '';
        if (selectedProducts.length === 0) {
            html = '<tr class="noproduct"><td colspan="3" class="text-center text-muted">No products selected</td></tr>';
        } else {
            selectedProducts.forEach(function(product, index) {
                console.log('Processing product at index', index, ':', product);
                html += '<tr data-product-id="' + product.id + '">';
                html += '<td>' + product.name + ' (' + product.code + ')</td>';
                html += '<td><input type="number" class="form-control quantity-input" value="' + product.quantity + '" min="1" data-index="' + index + '"></td>';
                html += '<td><button type="button" class="btn btn-danger btn-sm remove-product" data-index="' + index + '">Remove</button></td>';
                html += '</tr>';
            });
        }
        console.log('Generated HTML:', html);
        $('#product-table tbody').html(html);
    }
    
    // Auto-load product from URL parameter
    <?php if ($auto_product): ?>
    console.log('Auto product found:', <?php echo json_encode($auto_product); ?>);
    const autoProduct = <?php echo json_encode($auto_product); ?>;
    if (autoProduct && autoProduct.p_id) {
        console.log('Adding auto product to table:', autoProduct);
        console.log('Product ID:', autoProduct.p_id);
        console.log('Product Name:', autoProduct.p_name);
        console.log('Product Code:', autoProduct.p_code);
        console.log('Default Quantity:', autoProduct.default_quantity);
        addProductToTable(autoProduct);
    } else {
        console.log('Auto product is invalid:', autoProduct);
    }
    <?php else: ?>
    console.log('No auto product found');
    <?php endif; ?>
    
    // Product search functionality
    $('#product_search').on('input', function() {
        const query = $(this).val();
        if (query.length < 2) {
            $('#product_suggestions').hide();
            return;
        }
        
        // AJAX call to search products
        $.ajax({
            url: '../_inc/ajax.php',
            type: 'POST',
            data: {
                type: 'SEARCH_PRODUCTS',
                query: query
            },
            dataType: 'json',
            success: function(response) {
                if (response.success && response.data.length > 0) {
                    displayProductSuggestions(response.data);
                } else {
                    $('#product_suggestions').hide();
                }
            },
            error: function(xhr, status, error) {
                console.log('Search error:', xhr.responseText);
            }
        });
    });
    
    function displayProductSuggestions(products) {
        let html = '';
        products.forEach(function(product) {
            html += '<div class="suggestion-item" data-product-id="' + product.p_id + '" data-product-name="' + product.p_name + '" data-product-code="' + product.p_code + '" data-sell-price="' + (product.sell_price || '0.00') + '" data-unit-name="' + (product.unit_name || '') + '" data-category-name="' + (product.category_name || '') + '" data-quantity-in-stock="' + (product.quantity_in_stock || '0') + '" data-barcode-symbology="' + (product.barcode_symbology || 'code39') + '">';
            html += '<strong>' + product.p_name + '</strong> (' + product.p_code + ')';
            if (product.sell_price) {
                html += ' - $' + product.sell_price;
            }
            html += ' <span class="text-muted">- Stock: ' + (product.quantity_in_stock || '0') + '</span>';
            html += '</div>';
        });
        
        $('#product_suggestions').html(html).show();
    }
    
    // Handle product selection
    $(document).on('click', '.suggestion-item', function() {
        const productId = $(this).data('product-id');
        const productName = $(this).data('product-name');
        const productCode = $(this).data('product-code');
        const sellPrice = $(this).data('sell-price');
        const unitName = $(this).data('unit-name');
        const categoryName = $(this).data('category-name');
        const quantityInStock = $(this).data('quantity-in-stock');
        const barcodeSymbology = $(this).data('barcode-symbology');
        
        // Check if product already added
        if (selectedProducts.find(p => p.id === productId)) {
            alert('Product already added!');
            return;
        }
        
        const product = {
            id: productId,
            name: productName,
            code: productCode,
            sell_price: sellPrice,
            unit: unitName,
            category: categoryName,
            quantity_in_stock: quantityInStock,
            barcode_symbology: barcodeSymbology,
            quantity: Math.max(1, Math.floor(quantityInStock / 2)) // Default to available_qty/2
        };
        
        addProductToTable(product);
        $('#product_search').val('');
        $('#product_suggestions').hide();
    });
    
    // Handle quantity change
    $(document).on('change', '.quantity-input', function() {
        const index = $(this).data('index');
        const quantity = parseInt($(this).val());
        if (quantity > 0) {
            selectedProducts[index].quantity = quantity;
        }
    });
    
    // Handle product removal
    $(document).on('click', '.remove-product', function() {
        const index = $(this).data('index');
        selectedProducts.splice(index, 1);
        updateProductTable();
    });
    
    // Generate barcodes
    $('#generate_barcodes').on('click', function() {
        if (selectedProducts.length === 0) {
            alert('Please select at least one product!');
            return;
        }
        
        const perPage = $('#per_page').val();
        if (!perPage) {
            alert('Please select a page layout!');
            return;
        }
        
        generateBarcodes(selectedProducts, perPage);
    });
    
    function generateBarcodes(products, perPage) {
        let html = '';
        
        // Get field options
        const fields = {
            site_name: $('input[name="fields[site_name]"]').is(':checked'),
            product_name: $('input[name="fields[product_name]"]').is(':checked'),
            p_code: $('input[name="fields[p_code]"]').is(':checked'),
            price: $('input[name="fields[price]"]').is(':checked'),
            currency: $('input[name="fields[currency]"]').is(':checked'),
            unit: $('input[name="fields[unit]"]').is(':checked'),
            category: $('input[name="fields[category]"]').is(':checked'),
            product_image: $('input[name="fields[product_image]"]').is(':checked')
        };
        
        // Generate barcode HTML using the working structure from root barcode_print.php
        let barcodeCount = 0;
        products.forEach(function(product) {
            // Use product's barcode symbology or default to code39
            const barcodeType = product.barcode_symbology || 'code39';
            
            for (let i = 0; i < product.quantity; i++) {
                let itemClass = '';
                let containerClass = '';
                
                // Set classes based on layout
                if (perPage === 'tsc') {
                    itemClass = 'styleretsol tsc';
                    containerClass = 'barcode tsc-container';
                } else if (perPage === 'retsol') {
                    itemClass = 'styleretsol';
                    containerClass = 'barcode retsol-container';
                } else {
                    itemClass = 'style' + perPage;
                    containerClass = 'barcode barcodea4';
                }
                
                html += '<div class="item ' + itemClass + '" style="border: none; margin: 0; padding: 0;">';
                html += '<div class="item-inner" style="border: none; margin: 0; padding: 2px;">';
                
                // Site name
                if (fields.site_name) {
                    html += '<div style="text-align: center; padding-top: 2px; padding-bottom: 1px;">';
                    html += '<span class="barcode_site"><?php echo store("name"); ?></span>';
                    html += '</div>';
                }
                
                // Product name
                if (fields.product_name) {
                    html += '<div style="margin-bottom: 0; padding-bottom: 0; text-align: center;">';
                    html += '<span class="barcode_name">' + product.name + '</span>';
                    html += '</div>';
                }
                
                // Unit
                if (fields.unit && product.unit) {
                    html += '<span class="barcode_unit" style="font-size: 9px;">Unit: ' + product.unit + '</span>, ';
                }
                
                // Category
                if (fields.category && product.category) {
                    html += '<span class="barcode_category" style="font-size: 9px;">Category: ' + product.category + '</span> ';
                }
                
                // Product code
                if (fields.p_code) {
                    html += '<div class="text-center" style="font-size: 12px; margin: 0 auto; padding: 1px 0; text-align: center; width: 100%; font-weight: bold;">';
                    html += product.code;
                    html += '</div>';
                }
                
                // Barcode
                html += '<span class="barcode_image" style="margin: 0; padding: 0; display: flex; justify-content: center; width: 100%;">';
                html += '<svg class="barcode" data-code="' + product.code + '" data-type="' + barcodeType + '" style="height: 32px; max-height: 32px; margin: 0 auto;"></svg>';
                html += '</span>';
                
                // Price
                if (fields.price) {
                    html += '<div style="margin: 0 auto; padding: 0; display: flex; justify-content: center; width: 100%; text-align: center; gap: 0;">';
                    html += '<div style="font-weight: bold; font-size: 10px; text-align: center; width: 100%;">';
                    html += '<span>SALE: ';
                    if (fields.currency) {
                        html += '<?php echo get_currency_code(); ?> ';
                    }
                    html += (product.sell_price || '0.00');
                    html += '</span></div>';
                    html += '</div>';
                }
                
                html += '</div>';
                html += '</div>';
                barcodeCount++;
            }
        });
        
        // Wrap in appropriate container with exact dimensions
        let containerHtml = '';
        if (perPage === 'tsc') {
            containerHtml = '<div class="barcode tsc-container" style="width: 80mm; height: 25mm; overflow: hidden; border: none; margin: 0; padding: 0;">' + html + '</div>';
        } else if (perPage === 'retsol') {
            containerHtml = '<div class="barcode retsol-container" style="width: 100mm; height: 22mm; overflow: hidden; border: none; margin: 0; padding: 0;">' + html + '</div>';
        } else {
            containerHtml = '<div class="barcode barcodea4" style="width: 100%; max-width: 210mm; overflow: hidden; border: none;">' + html + '</div>';
        }
        
        $('#barcode-container').html(containerHtml);
        
        // Generate actual barcodes using JsBarcode
        $('.barcode svg').each(function() {
            const code = $(this).data('code');
            const type = $(this).data('type');
            
            try {
                JsBarcode(this, code, {
                    format: type,
                    width: 1,
                    height: 32,
                    displayValue: false,
                    fontSize: 8
                });
            } catch (e) {
                console.log('Error generating barcode for ' + code + ': ' + e.message);
                $(this).html('<div style="color: red;">Error: ' + e.message + '</div>');
            }
        });
        
        $('#barcode-display').show();
    }
    
    // Print function - Fixed to prevent layout disturbance
    window.printBarcodes = function() {
        // Store original content and elements
        const originalBody = document.body.cloneNode(true);
        const originalTitle = document.title;
        
        const printContent = $('#barcode-container').html();
        const perPage = $('#per_page').val();
        
        let pageSize = 'auto';
        let containerStyles = '';
        
        if (perPage === 'tsc') {
            pageSize = '80mm 25mm';
            containerStyles = '.barcode.tsc-container { width: 80mm !important; height: 25mm !important; max-width: 80mm !important; margin: 0 !important; padding: 0 !important; display: flex !important; flex-wrap: wrap !important; } .barcode.tsc-container .item.styleretsol.tsc { width: 38mm !important; height: 25mm !important; flex: 0 0 38mm !important; margin: 0 !important; padding: 0 !important; }';
        } else if (perPage === 'retsol') {
            pageSize = '100mm 22mm';
            containerStyles = '.barcode.retsol-container { width: 100mm !important; height: 22mm !important; max-width: 100mm !important; margin: 0 !important; padding: 0 !important; display: flex !important; flex-wrap: wrap !important; } .barcode.retsol-container .item.styleretsol { width: 50mm !important; height: 22mm !important; flex: 0 0 50mm !important; margin: 0 !important; padding: 0 !important; }';
        } else {
            pageSize = 'A4 portrait';
        }
        
        // Create a new window for printing to avoid layout disturbance
        const printWindow = window.open('', '_blank', 'width=800,height=600');
        
        printWindow.document.write(
            '<!DOCTYPE html>' +
            '<html><head>' +
            '<title>Barcode Print</title>' +
            '<link type="text/css" href="../assets/itsolution24/css/barcode.css" rel="stylesheet">' +
            '<link type="text/css" href="../barcode.css" rel="stylesheet">' +
            '<style>' +
            '@page { size: ' + pageSize + '; margin: 0mm; }' +
            'html, body { height: 100%; width: 100%; margin: 0; padding: 0; overflow: hidden; font-family: Arial, sans-serif; }' +
            '.barcode { max-width: 100%; overflow: visible; page-break-inside: avoid; margin: 0 !important; padding: 0 !important; }' +
            containerStyles +
            '.barcode_site { font-size: 13px !important; font-weight: bold; margin: 0 !important; padding-top: 2px !important; padding-bottom: 1px !important; text-align: center !important; display: block !important; width: 100% !important; text-transform: uppercase !important; }' +
            '.barcode_name { font-size: 11px !important; font-weight: bold; margin: 0 !important; padding: 0 !important; text-align: center !important; display: block !important; width: 100% !important; }' +
            '.barcode_image { margin: 0 !important; padding: 0 !important; text-align: center !important; display: flex !important; justify-content: center !important; align-items: center !important; width: 100% !important; }' +
            '.barcode_image svg { max-height: 32px !important; margin: 0 auto !important; display: block !important; }' +
            '.item-inner { padding: 2px !important; margin: 0 !important; text-align: center !important; }' +
            '.item-inner div { margin: 0 !important; padding: 0 !important; line-height: 1.1 !important; text-align: center !important; }' +
            '</style>' +
            '</head><body>' +
            '<div class="barcode">' + printContent + '</div>' +
            '</body></html>'
        );
        
        printWindow.document.close();
        
        // Wait for content to load, then print
        printWindow.onload = function() {
            printWindow.print();
            printWindow.close();
        };
        
        // Fallback: if onload doesn't fire, print after a short delay
        setTimeout(function() {
            if (!printWindow.closed) {
                printWindow.print();
                printWindow.close();
            }
        }, 1000);
    };
    
    // Hide suggestions when clicking outside
    $(document).on('click', function(e) {
        if (!$(e.target).closest('#product_search, #product_suggestions').length) {
            $('#product_suggestions').hide();
        }
    });
});
</script>

<style>
/* Enhanced UI Styles */
.suggestion-item {
    padding: 12px 16px;
    cursor: pointer;
    border-bottom: 1px solid #eee;
    transition: all 0.2s ease;
    border-left: 3px solid transparent;
}

.suggestion-item:hover {
    background-color: #f8f9fa;
    border-left-color: #007bff;
    transform: translateX(2px);
}

.suggestion-item:last-child {
    border-bottom: none;
}

#product_suggestions {
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    background: white;
    z-index: 1000;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
}

.well {
    border-radius: 8px;
    border: 1px solid #e3e6f0;
    box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
}

.well.bg-gray {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.form-control {
    border-radius: 6px;
    border: 1px solid #d1d3e2;
    transition: all 0.15s ease-in-out;
}

.form-control:focus {
    border-color: #bac8f3;
    box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
}

.btn {
    border-radius: 6px;
    font-weight: 600;
    transition: all 0.2s ease;
}

.btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
}

.btn-success {
    background: linear-gradient(135deg, #56ab2f 0%, #a8e6cf 100%);
    border: none;
}

.btn-danger {
    background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
    border: none;
}

.table {
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
}

.table thead th {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.85rem;
    letter-spacing: 0.5px;
}

.table tbody tr {
    transition: all 0.2s ease;
}

.table tbody tr:hover {
    background-color: #f8f9fa;
    transform: scale(1.01);
}

#available-qty-display {
    padding: 8px 12px;
    background: #e8f5e8;
    border: 1px solid #c3e6c3;
    border-radius: 6px;
    font-weight: 600;
}

.checkbox label {
    font-weight: 500;
    margin-right: 20px;
    cursor: pointer;
    transition: color 0.2s ease;
}

.checkbox label:hover {
    color: #007bff;
}

.checkbox input[type="checkbox"] {
    margin-right: 8px;
    transform: scale(1.2);
}

#barcode-display {
    margin-top: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
    border: 1px solid #e3e6f0;
}

#barcode-display h4 {
    color: #5a5c69;
    font-weight: 600;
    margin-bottom: 20px;
}

/* Loading animation */
.btn[data-loading-text] {
    position: relative;
}

.btn[data-loading-text]:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.btn[data-loading-text]:disabled::after {
    content: "";
    position: absolute;
    width: 16px;
    height: 16px;
    top: 50%;
    left: 50%;
    margin-left: -8px;
    margin-top: -8px;
    border: 2px solid #ffffff;
    border-radius: 50%;
    border-top-color: transparent;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

/* Responsive improvements */
@media (max-width: 768px) {
    .col-md-6 {
        margin-bottom: 15px;
    }
    
    .btn-group {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    
    .btn-group .btn {
        width: 100%;
        margin: 0;
    }
}

/* TSC Layout - Exact 8cm x 2.5cm dimensions */
.barcode.tsc-container {
    width: 80mm !important;
    height: 25mm !important;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    page-break-inside: avoid !important;
    display: flex !important;
    flex-wrap: wrap !important;
}

.barcode.tsc-container .item.styleretsol.tsc {
    width: 38mm !important; /* 3.8cm per column */
    height: 25mm !important; /* 2.5cm height */
    margin: 0 !important;
    padding: 0 !important;
    box-sizing: border-box !important;
    flex: 0 0 38mm !important;
    display: inline-block !important;
}

/* Retsol Layout - Exact 10cm x 2.2cm dimensions */
.barcode.retsol-container {
    width: 100mm !important;
    height: 22mm !important;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    page-break-inside: avoid !important;
}

.barcode.retsol-container .item.styleretsol {
    width: 50mm !important; /* 5cm per column for 2-column layout */
    height: 22mm !important; /* 2.2cm height */
    float: left !important;
    margin: 0 !important;
    padding: 0 !important;
    box-sizing: border-box !important;
}

/* Print styles for exact dimensions */
@media print {
    .barcode.tsc-container {
        width: 80mm !important;
        height: 25mm !important;
        margin: 0 !important;
        padding: 0 !important;
        display: flex !important;
        flex-wrap: wrap !important;
    }
    
    .barcode.tsc-container .item.styleretsol.tsc {
        width: 38mm !important;
        height: 25mm !important;
        flex: 0 0 38mm !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    
    .barcode.retsol-container {
        width: 100mm !important;
        height: 22mm !important;
        margin: 0 !important;
        padding: 0 !important;
        display: flex !important;
        flex-wrap: wrap !important;
    }
    
    .barcode.retsol-container .item.styleretsol {
        width: 50mm !important;
        height: 22mm !important;
        flex: 0 0 50mm !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    
    @page {
        size: 80mm 25mm;
        margin: 0;
    }
}
</style>

<?php include ("footer.php"); ?>
