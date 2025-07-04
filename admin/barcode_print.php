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

// Set Document Title
$document->setTitle(trans('title_barcode'));

// Add Style
$document->addStyle('../assets/itsolution24/css/barcode.css', 'stylesheet', 'all');

// Add Script
$document->addScript('../assets/itsolution24/angular/controllers/BarcodePrintController.js');

// ADD BODY CLASS
$document->setBodyClass('sidebar-collapse');

// Include Header and Footer
include("header.php"); 
include ("left_sidebar.php") ;
?>

<!-- Content Wrapper Start -->
<div class="content-wrapper" ng-controller="BarcodePrintController">

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
      <li>
        <?php if (isset($request->get['box_state']) && $request->get['box_state']=='open'): ?>
          <a href="barcode_print.php"><?php echo trans('text_barcode_title'); ?></a>  
        <?php else: ?>
          <?php echo trans('text_barcode_title'); ?>  
        <?php endif; ?>
      </li>
      <?php if (isset($request->get['box_state']) && $request->get['box_state']=='open'): ?>
        <li class="active">
          <?php echo trans('text_add'); ?> 
        </li>
      <?php endif; ?>
    </ol>
  </section>
  <!-- Content Header end -->

  <!-- Content Start -->
  <section class="content">

    <?php if(DEMO) : ?>
    <div class="box">
      <div class="box-body">
        <div class="alert alert-info mb-0">
          <p><span class="fa fa-fw fa-info-circle"></span> <?php echo $demo_text; ?></p>
        </div>
      </div>
    </div>
    <?php endif; ?>

    <div class="row">
      <div class="col-xs-12">
        <div class="box box-success">
          <div class="box-header">
            <h3 class="box-title">
              <?php echo trans('text_barcode_generate_title'); ?>
            </h3>
          </div>
          <div class='box-body'> 
            <form id="form-barcode-generate" class="form-horizontal" action="barcode_print.php#barcode-con" method="post" target="_self">
              <div class="well well-sm">
                <div class="well well-sm bg-gray r-50">
                  <div class="form-group mb-0">
                    <label for="add_item" class="col-sm-3 control-label">
                      <?php echo trans('label_add_product'); ?>
                    </label>
                    <div class="col-sm-6">
                      <div class="input-group wide-tip">
                        <div class="input-group-addon paddinglr-10">
                          <i class="fa fa-barcode addIcon fa-2x"></i>
                        </div>
                        <input type="text" name="add_item" value="" class="form-control input-lg autocomplete-product" id="add_item" data-type="p_name" onkeypress="return event.keyCode != 13;" onclick="this.select();" placeholder="<?php echo trans('placeholder_search_product'); ?>" autocomplete="off" tabindex="1">
                      </div>
                    </div>  
                  </div> 
                </div> 

                <div class="row">
                  <div class="col-md-12">
                    <div class="table-responsive">
                      <table id="product-table" class="table table-striped table-bordered">
                        <thead>
                          <tr class="bg-info">
                            <th class="w-50 text-center">
                              <?php echo trans('label_product_name_with_code'); ?>
                            </th>
                            <th class="w-20 text-center">
                              <?php echo trans('label_available'); ?>
                            </th>
                            <th class="w-20 text-center">
                              <?php echo trans('label_quantity'); ?>
                            </th>
                            <th class="w-10 text-center">
                              <?php echo trans('label_delete'); ?>
                            </th>
                          </tr>
                        </thead>
                        <tbody>
                          <?php if (isset($request->post['products']) && !empty($request->post['products'])) : 
                          foreach ($request->post['products'] as $item): $product = get_the_product($item['item_id']); ?>
                            <tr id="<?php echo $product['p_id'];?>" class="<?php echo $product['p_id'];?> success" data-item-id="<?php echo $product['p_id'];?>">
                              <td class="text-center"  data-title="Product Name">
                                <input name="products[<?php echo $product['p_id'];?>][item_id]" type="hidden" class="item-id" value="<?php echo $product['p_id'];?>">
                                <input name="products[<?php echo $product['p_id'];?>][item_name]" type="hidden" class="item-name" value="<?php echo $product['p_name'];?>">
                                <span class="name" id="name-<?php echo $product['p_id'];?>"><?php echo $product['p_name'];?>-<?php echo $product['p_code'];?></span>
                              </td>
                              <td class="text-center" data-title="Available"><?php echo format_input_number($product['quantity_in_stock']);?></td>
                              <td data-title="Quantity">
                                <input class="form-control input-sm text-center quantity" name="products[<?php echo $product['p_id'];?>][quantity]" type="number" value="<?php echo $item['quantity'];?>" data-id="<?php echo $product['p_id'];?>" id="quantity-<?php echo $product['p_id'];?>" onclick="this.select();" onkeyup="if(this.value<=0){this.value=1;}">
                              </td>
                              <td class="text-center">
                                <i class="fa fa-close text-red pointer remove" data-id="<?php echo $product['p_id'];?>" title="Remove"></i>
                              </td>
                            </tr>
                          <?php endforeach;?>
                          <?php endif;?>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>

                <div class="well well-sm r-50" >
                  <div class="form-group">
                    <label for="per_page" class="col-sm-3 control-label">
                      <?php echo trans('label_page_layout'); ?>
                    </label>
                    <div class="col-sm-6">
                      <select name="per_page" class="form-control" id="per_page">
                        <option value=""><?php echo trans('text_select');?></option>
                        <option value="40" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 40 ? 'selected' : null;?>>40 per sheet (a4) (1.799" x 1.003")</option>
                        <option value="30" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 30 ? 'selected' : null;?>>30 per sheet (2.625" x 1")</option>
                        <option value="24" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 24 ? 'selected' : null;?>>24 per sheet (a4) (2.48" x 1.334")</option>
                        <option value="20" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 20 ? 'selected' : null;?>>20 per sheet (4" x 1")</option>
                        <option value="18" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 18 ? 'selected' : null;?>>18 per sheet (a4) (2.5" x 1.835")</option>
                        <option value="14" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 14 ? 'selected' : null;?>>14 per sheet (4" x 1.33")</option>
                        <option value="12" 
                          <?php if(isset($request->post['per_page']) && $request->post['per_page'] == 12) {
                            echo 'selected';
                          }?>
                        >12 per sheet (a4) (2.5" x 2.834")</option>
                        <option value="10" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 10 ? 'selected' : null;?>>10 per sheet (4" x 2")</option>
                        <option value="retsol" <?php echo isset($request->post['per_page']) && $request->post['per_page'] == 'retsol' ? 'selected' : 'selected';?>>Retsol (10cm x 2.2cm - 2 columns)</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group mb-0">
                    <label class="col-sm-3 control-label"><?php echo trans('label_fields');?></label>
                    <div class="col-sm-6">
                        <div class="checkbox">
                          <label><input type="checkbox" name="fields[site_name]" value="1" checked>Site name</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[product_name]" value="1" checked>Product name</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[p_code]" value="1" checked>Product code</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[price]" value="1" checked>Price</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[currency]" value="1">Currency</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[unit]" value="1">Unit</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[category]" value="1">Category</label>&nbsp;&nbsp;&nbsp;
                          <label><input type="checkbox" name="fields[product_image]" value="1">Product Image</label>
                        </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-3 col-sm-offset-3 text-center">            
                    <button id="barcode-generate" class="btn btn-info btn-block" data-form="#form-barcode-generate" name="submit" data-loading-text="Generating...">
                      <i class="fa fa-fw fa-cog"></i>
                      <?php echo trans('button_generate'); ?>
                    </button>
                  </div>
                  <div class="col-sm-3 text-center">            
                    <a href="barcode_print.php"  class="btn btn-danger btn-block">
                      <span class="fa fa-fw fa-circle-o"></span>
                      <?php echo trans('button_reset'); ?>
                    </a>
                  </div>
                </div>
              </div>
            </form>
                            <div id="barcode-con">
              <?php 
              if(isset($request->post['products'])):
                $per_page = $request->post['per_page'];
                if (!$per_page) {
                  redirect(root_url().'admin/barcode_print.php');
                }
                $page_layout = '';
                switch ($per_page) {
                  case '10':
                    $page_layout = '';
                    break;
                  case '12':
                    $page_layout = 'a4';
                    break;
                  case '14':
                    $page_layout = '';
                    break;
                  case '18':
                    $page_layout = 'a4';
                    break;
                  case '20':
                    $page_layout = '';
                    break;
                  case '24':
                    $page_layout = 'a4';
                    break;
                  case '30':
                    $page_layout = '';
                    break;
                  case '40':
                    $page_layout = 'a4';
                    break;
                  case 'retsol':
                    $page_layout = 'a4';
                    break;
                  default:
                    $page_layout = '';
                    break;
                }
                
                // For retsol layout, we'll handle the page breaks differently
                $items_per_page = ($per_page == 'retsol') ? 2 : $per_page;
                
                // Barcode
                $generator = barcode_generator();
                
                // Count total barcodes to be generated
                $total_barcodes = 0;
                foreach ($request->post['products'] as $prod) {
                  $total_barcodes += $prod['quantity'];
                }
                ?>

                  <?php 
                  // Generate all barcodes
                  $all_barcodes = array();
                  foreach ($request->post['products'] as $prod): 
                    $product = get_the_product($prod['item_id']);
                    $symbology = $product['barcode_symbology'] ? $product['barcode_symbology'] : 'code39';
                    $symbology = barcode_symbology($generator, $symbology);
                    
                    for ($i=0; $i < $prod['quantity']; $i++): 
                      $barcode_html = '';
                      ob_start();
                      ?>
                      <?php if ($per_page == 'retsol'): ?>
                      <div class="item styleretsol" style="border: none; margin: 0; padding: 0;">
                      <?php else: ?>
                      <div class="item <?php echo 'style'.$per_page; ?>" style="border: none; margin: 0; padding: 0;">
                      <?php endif; ?>
                        <div class="item-inner" style="border: none; margin: 0; padding: 2px;">
                          <?php if (isset($request->post['fields']['product_image']) && $request->post['fields']['product_image']):?>
                            <span class="product_image">
                                <?php if (isset($product['p_image']) && ((FILEMANAGERPATH && is_file(FILEMANAGERPATH.$product['p_image']) && file_exists(FILEMANAGERPATH.$product['p_image'])) || (is_file(DIR_STORAGE . 'products' . $product['p_image']) && file_exists(DIR_STORAGE . 'products' . $product['p_image'])))) : ?>
                                <img  src="<?php echo FILEMANAGERURL ? FILEMANAGERURL : root_url().'storage/products'; ?>/<?php echo $product['p_image']; ?>" alt="product img">
                              <?php else : ?>
                                <img src="../assets/itsolution24/img/noimage.jpg" alt="default img">
                              <?php endif; ?>
                            </span>
                          <?php endif;?>
                          <?php if (isset($request->post['fields']['site_name']) && $request->post['fields']['site_name']):?>
                            <div style="text-align: center; padding-top: 2px; padding-bottom: 1px;">
                              <span class="barcode_site"><?php echo store('name');?></span>
                            </div>
                          <?php endif;?>
                          <?php if (isset($request->post['fields']['product_name']) && $request->post['fields']['product_name']):?>
                            <?php 
                              // Parse product name for MRP
                              $full_name = $product['p_name'];
                              $mrp_value = null;
                              $product_display_name = $full_name;
                              
                              // Look for '-' followed by digits pattern
                              if (preg_match('/(.*)-(\d+)/', $full_name, $matches)) {
                                $product_display_name = trim($matches[1]);
                                $mrp_value = trim($matches[2]);
                              }
                              
                              // Handle case with colon-separated barcode
                              if (strpos($product_display_name, ':') !== false) {
                                $product_display_name = trim(explode(':', $product_display_name)[0]);
                              }
                            ?>
                            <div style="margin-bottom: 0; padding-bottom: 0; text-align: center;">
                              <span class="barcode_name"><?php echo $product_display_name;?></span>
                            </div>
                          <?php endif;?>
                          <?php if (isset($request->post['fields']['unit']) && $request->post['fields']['unit']):?>
                            <span class="barcode_unit" style="font-size: 9px;"><?php echo trans('label_unit');?>: <?php echo get_the_unit($product['unit_id'],'unit_name');?></span>, 
                          <?php endif;?>
                          <?php if (isset($request->post['fields']['category']) && $request->post['fields']['category']):?>
                            <span class="barcode_category" style="font-size: 9px;"><?php echo trans('label_category');?>: <?php echo get_the_category($product['category_id'],'category_name');?></span> 
                          <?php endif;?>
                          <?php if (isset($request->post['fields']['p_code']) && $request->post['fields']['p_code']):?>
                            <div class="text-center" style="font-size: 12px; margin: 0 auto; padding: 1px 0; text-align: center; width: 100%; font-weight: bold;">
                              <?php echo $product['p_code'];?>
                            </div>
                          <?php endif;?>
                          <span class="barcode_image" style="margin: 0; padding: 0; display: flex; justify-content: center; width: 100%;">
                            <img src="data:image/png;base64,<?php echo encode_data($generator->getBarcode($product['p_code'], $symbology, 1));?>" alt="<?php echo $product['p_code'];?>" class="bcimg" style="height: 32px; max-height: 32px; margin: 0 auto;">
                          </span>
                          <?php if (isset($request->post['fields']['price']) && $request->post['fields']['price']):?>
                            <div style="margin: 0 auto; padding: 0; display: flex; justify-content: center; width: 100%; text-align: center; gap: 0;">
                              <?php if ($mrp_value): ?>
                                <div style="font-size: 10px; margin-right: 0; text-align: left; margin-left: 0; width: 40%; padding-left: 3px; font-weight: bold;">
                                  <span>MRP:<?php if (isset($request->post['fields']['currency']) && $request->post['fields']['currency']): ?><?php echo get_currency_code();?><?php endif;?><?php echo $mrp_value;?></span>
                                </div>
                              <?php endif;?>
                              <div style="font-weight: bold; font-size: 10px; text-align: right; width: 40%; padding-right: 3px; margin-left: -15px;">
                                <span>SALE:
                                <?php if (isset($request->post['fields']['currency']) && $request->post['fields']['currency']):?>
                                <?php echo get_currency_code();?> 
                                <?php endif;?>
                                <?php 
                                $price = $product['sell_price'];
                                $formatted_price = number_format($price, 0);
                                echo $formatted_price;
                                ?></span>
                              </div>
                            </div>
                          <?php endif;?>
                          </span>
                        </div>
                      </div>
                      <?php
                      $barcode_html = ob_get_clean();
                      $all_barcodes[] = $barcode_html;
                    endfor;
                  endforeach;
                  
                  // Calculate how many barcodes we have
                  $barcode_count = count($all_barcodes);
                  
                  // Only display a single print-optimized container
                  ?>
                  <style>
                    /* General styles for barcode elements */
                    .barcode_site {
                      font-size: 13px !important;
                      font-weight: bold;
                      margin: 0 !important;
                      padding-top: 2px !important;
                      padding-bottom: 1px !important;
                      text-align: center !important;
                      display: block !important;
                      width: 100% !important;
                      text-transform: uppercase !important;
                    }
                    .barcode_name {
                      font-size: 11px !important;
                      font-weight: bold;
                      margin: 0 !important;
                      padding: 0 !important;
                      text-align: center !important;
                      display: block !important;
                      width: 100% !important;
                    }
                    .barcode_price {
                      font-size: 9px !important;
                      font-weight: bold;
                      margin: 0 !important;
                      padding: 0 !important;
                      text-align: center !important;
                    }
                    .barcode_unit, .barcode_category {
                      font-size: 8px !important;
                      margin: 0 !important;
                      padding: 0 !important;
                      text-align: center !important;
                    }
                    .barcode_image {
                      margin: 0 !important;
                      padding: 0 !important;
                      text-align: center !important;
                      display: flex !important;
                      justify-content: center !important;
                      align-items: center !important;
                      width: 100% !important;
                    }
                    .barcode_image img {
                      max-height: 32px !important;
                      margin: 0 auto !important;
                      display: block !important;
                    }
                    .barcode_image .text-center {
                      font-size: 12px !important;
                      margin: 0 !important;
                      padding: 1px 0 !important;
                      text-align: center !important;
                      width: 100% !important;
                      font-weight: bold !important;
                    }
                    .item-inner {
                      padding: 2px !important;
                      margin: 0 !important;
                      text-align: center !important;
                    }
                    .item-inner div {
                      margin: 0 !important;
                      padding: 0 !important;
                      line-height: 1.1 !important;
                      text-align: center !important;
                    }
                    
                    @media print {
                      #print-buttons { display: none !important; }
                      .barcode { 
                        page-break-after: avoid !important;
                        page-break-inside: avoid !important;
                        page-break-before: avoid !important;
                        max-height: 99vh !important;
                        max-width: 99vw !important;
                        overflow: hidden !important;
                        break-inside: avoid !important;
                      }
                      .barcode .item { 
                        break-inside: avoid !important;
                        border: none !important;
                        transform: scale(0.95);
                      }
                      .barcode .item-inner { 
                        border: none !important;
                        padding: 2px !important;
                        margin: 0 !important;
                      }
                      .barcode_site {
                        padding-top: 0 !important;
                        font-size: 12px !important;
                      }
                      html, body { 
                        height: 100% !important; 
                        width: 100% !important; 
                        margin: 0 !important; 
                        padding: 0 !important;
                        overflow: hidden !important;
                      }
                      @page {
                        size: A4 portrait;
                        margin: 0;
                        padding: 0;
                      }
                      .box, .content, .content-wrapper {
                        margin: 0 !important;
                        padding: 0 !important;
                      }
                    }
                  </style>
                  
                  <div id="single-page-container" style="max-width: 100%; max-height: 100%; overflow: hidden;">
                    <?php if ($per_page == 'retsol'): ?>
                    <div class="barcode barcodea4" style="width: 100%; max-width: 210mm; overflow: hidden; border: none;">
                    <?php else: ?>
                    <div class="barcode barcode<?php echo $page_layout;?>" style="width: 100%; max-width: 210mm; overflow: hidden; border: none;">
                    <?php endif; ?>
                  
                  <?php
                  // Output just the barcodes without empty spaces
                  foreach ($all_barcodes as $barcode):
                    echo $barcode;
                  endforeach;
                  ?>
                  </div>
                  </div>
                
                <div class="text-center" id="print-buttons">
                  <div class="btn-group">
                    <button class="btn btn-lg btn-primary" onClick="printBarcodes();"><span class="fa fa-print"></span> <?php echo trans('button_print');?></button>
                  </div>
                </div>
                
                <script>
                                  function printBarcodes() {
                  // Hide everything except the barcode container
                  var originalContent = document.body.innerHTML;
                  var printContent = document.getElementById('single-page-container').innerHTML;
                  
                  // Create a new document for printing
                  document.body.innerHTML = 
                    '<html><head>' +
                    '<link type="text/css" href="../assets/itsolution24/css/barcode.css" rel="stylesheet">' +
                    '<style>' +
                    '@page { size: auto; margin: 0mm; }' +
                    'html, body { height: 100%; width: 100%; margin: 0; padding: 0; }' +
                    '.barcode { max-width: 100%; overflow: visible; page-break-inside: avoid; }' +
                    '.barcode_site { font-size: 13px !important; font-weight: bold; margin: 0 !important; padding-top: 2px !important; padding-bottom: 1px !important; text-align: center !important; display: block !important; width: 100% !important; text-transform: uppercase !important; }' +
                    '.barcode_name { font-size: 11px !important; font-weight: bold; margin: 0 !important; padding: 0 !important; text-align: center !important; display: block !important; width: 100% !important; }' +
                    '.barcode_image { margin: 0 !important; padding: 0 !important; text-align: center !important; display: flex !important; justify-content: center !important; align-items: center !important; width: 100% !important; }' +
                    '.barcode_image img { max-height: 32px !important; margin: 0 auto !important; display: block !important; }' +
                    '.barcode_image .text-center { font-size: 12px !important; margin: 0 !important; padding: 1px 0 !important; text-align: center !important; width: 100% !important; font-weight: bold !important; }' +
                    '.item-inner { padding: 2px !important; margin: 0 !important; text-align: center !important; }' +
                    '.item-inner div { margin: 0 !important; padding: 0 !important; line-height: 1.1 !important; text-align: center !important; }' +
                    '.barcode .item { transform: scale(0.95); }' +
                    '.item-inner div[style*="display: flex"] { justify-content: center !important; margin: 0 auto !important; padding: 0 !important; gap: 0 !important; }' +
                    '.item-inner div[style*="display: flex"] div:first-child { margin-right: 0 !important; text-align: left !important; margin-left: 0 !important; width: 40% !important; padding-left: 3px !important; font-weight: bold !important; }' +
                    '.item-inner div[style*="display: flex"] div:last-child { text-align: right !important; width: 40% !important; padding-right: 3px !important; margin-left: -15px !important; }' +
                    
                    '</style>' +
                    '</head><body>' +
                    '<div class="barcode">' + printContent + '</div>' +
                    '</body></html>';
                  
                  // Print the document
                  window.print();
                  
                  // Restore the original content
                  setTimeout(function() {
                    document.body.innerHTML = originalContent;
                    // Re-add the event listener
                    document.querySelector('#print-buttons button').addEventListener('click', printBarcodes);
                  }, 500);
                }
                </script>

              <?php endif;?>
            </div>
          </div>
          <!-- .box-body -->
        </div>
      </div>
    </div>
  </section>
</div>
<!-- Content Wrapper End -->

<?php include ("footer.php"); ?>