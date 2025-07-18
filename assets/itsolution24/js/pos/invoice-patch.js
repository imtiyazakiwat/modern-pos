/**
 * Invoice Patch for PrintReceiptModal
 * 
 * This script directly patches the PrintReceiptModal function in modal.js
 * to fix the issue with customer_mobile being undefined
 */
(function() {
    // Wait for DOM and Angular to be ready
    function initPatch() {
        if (!window.angular || !window.angularApp) {
            setTimeout(initPatch, 500);
            return;
        }
        
        console.log('Applying invoice PrintReceiptModal patch');
        
        // Add a PDF receipt generator as a fallback option
        window.generatePDFReceipt = function(scope) {
            try {
                console.log("Generating PDF receipt as a fallback");
                
                // Check if required data exists
                if (!scope.invoiceInfo) {
                    console.error("Missing invoice info for PDF generation");
                    return;
                }
                
                // Store and payment info
                var storeName = window.store && window.store.name ? window.store.name : 'Store';
                var storeAddress = window.store && window.store.address ? window.store.address : '';
                var storeMobile = window.store && window.store.mobile ? window.store.mobile : '';
                var storeEmail = window.store && window.store.email ? window.store.email : 'info@store1.com';
                var invoiceId = scope.invoiceInfo.invoice_id || '';
                var vatReg = scope.invoiceInfo.tax_reg_no || '';
                var gstReg = '';
                var createdAt = scope.invoiceInfo.created_at || '';
                var customerName = scope.invoiceInfo.customer_name || 'Walking Customer';
                var customerContact = '';
                var customerAddress = 'athani';
                var customerGTIN = '147258';
                
                // Get customer contact - safely
                if (scope.invoiceInfo.customer_mobile && scope.invoiceInfo.customer_mobile !== "undefined") {
                    customerContact = scope.invoiceInfo.customer_mobile;
                } else if (scope.invoiceInfo.mobile_number && scope.invoiceInfo.mobile_number !== "undefined") {
                    customerContact = scope.invoiceInfo.mobile_number;
                } else if (scope.invoiceInfo.customer_email && scope.invoiceInfo.customer_email !== "undefined") {
                    customerContact = scope.invoiceInfo.customer_email;
                }
                
                // UPI payment details
                var upiId = window.store && window.store.upi_id ? window.store.upi_id : 'hanamantmokashi@ybl';
                var paymentReference = 'INV' + invoiceId;
                
                // Safely get numeric values
                var subtotal = parseFloat(scope.invoiceInfo.subtotal || 0);
                var orderTax = parseFloat(scope.invoiceInfo.order_tax || 0);
                var discountAmount = parseFloat(scope.invoiceInfo.discount_amount || 0);
                var shippingAmount = parseFloat(scope.invoiceInfo.shipping_amount || 0);
                var othersCharge = parseFloat(scope.invoiceInfo.others_charge || 0);
                var previousDue = parseFloat(scope.invoiceInfo.previous_due || 0);
                var payableAmount = parseFloat(scope.invoiceInfo.payable_amount || 0);
                var paidAmount = parseFloat(scope.invoiceInfo.paid_amount || 0);
                var dueAmount = parseFloat(scope.invoiceInfo.due || 0);
                var changeAmount = parseFloat(scope.invoiceInfo.balance || 0);
                var prevDuePaid = parseFloat(scope.invoiceInfo.prev_due_paid || 0);
                var totalDue = dueAmount;
                var paymentMethod = scope.invoiceInfo.payment_method || 'UPI Payment';
                
                // Format numbers for display
                function formatNumber(num) {
                    return num.toFixed(2);
                }
                
                // Check if store has a logo URL
                var logoUrl = '';
                if (window.store && window.store.logo) {
                    // Proper path to logo in the system
                    var baseUrl = window.baseUrl || '';
                    logoUrl = baseUrl + 'assets/itsolution24/img/logo-favicons/' + window.store.logo;
                }
                
                // Base64 encoded Modern POS logo - embedding directly to avoid loading issues
                var logoBase64 = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACECAMAAAC82akHAAAAM1BMVEX///8AAADBwcHm5uYtLS2UlJRtbW1MTEzd3d1jY2Pf39/y8vLZ2dmnp6fJycl9fX2Li4uRJv1pAAAC/ElEQVR4nO3c23KrIBRAUQni/XT8/589aK0xpLU9JW2HrfMwbYMgq+KAl9sNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALKJ0/J8MHiSz8n+R19n4uMVM5zVG5dz49KRSGXPyrlv15q8qNVt52ZX0QV33azmE9qKn2eqLdx21EELdVLrSTeL4ddnO9pVWobR+lJW0lQ+ZvK02r98n266mjKROrYeNb0TPBt83wXmg1Vo6/1Jyc4yWqqhk1ncbX8nvnw6+f+wU4exLMlus9a1sA4/tzA9/Nvj+6SZlpzWk7AstOdp0qnZJw8NV9fsGcdNy9HqlS+o2cZYV6+64HkOqqpZTVbVvmkuWd3aNj8tffPS2hUon/C0t2WW1scc3IbfeKY0PiSuU6jo/DZn89vQQcdMSNVq6vqWR7FqbEO7yqrkQU8uiTfNop9bkPD61KauY8vKh71+U+2fbKVN7Sjbsa6jX/ubeRpSUNd/G1s9C1/dmfUvXT5/Gvt/q3l6t4OPry0ox9W5yTaF6Obo7+wtZeuvh4YZQNoe85jhKdJM0zc+S7Qfc8+37rG9tU+ZtD5PXK+RnrO8y7Vj3KL5TSKXTYzOlY2P3+q7OgnWipBZOQ+hXldbvT9XXw+fSX/3l6lG3UsQQnjO2buZCab32Tbe+77/2/fH7k0hpYL7o5iv0kj7aXNCTM5Qub63SY5REzgfl9p3tuVRU28UVnp8q5E2fdd53vqgrXm3pmbmM3lsfTZ17gVZm+PG5yZsbTpsEHZlO1pfda8739q/+s+ICjb/yZHSxDiO3To05j+vCre8/O2csM55+QfPTwbPdyPZaQyu3irF2nrJz66Q5VmV2lkwcTwya55FvLIInb2rPXERvpZrLYXnMp+bNL1l1Q5R58wudOzSd/IhhSnrc2ymV+oInGKpGp9tjaSrbvpJNF2xlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/Elf7QYTYYdxhDcAAAAASUVORK5CYII=";
                
                // Create a full page invoice HTML structure
                var invoiceHTML = `
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Invoice #${invoiceId}</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            margin: 0;
                            padding: 20px;
                            color: #000;
                            font-size: 12px;
                        }
                        .invoice-container {
                            max-width: 800px;
                            margin: 0 auto;
                        }
                        .logo-container {
                            text-align: center;
                            margin-bottom: 10px;
                        }
                        .logo {
                            max-width: 100px;
                            max-height: 60px;
                        }
                        .store-name {
                            text-align: center;
                            font-size: 18px;
                            font-weight: bold;
                            margin-bottom: 5px;
                        }
                        .store-address {
                            text-align: center;
                            margin-bottom: 5px;
                        }
                        .store-contact {
                            text-align: center;
                            margin-bottom: 15px;
                        }
                        .invoice-details {
                            width: 100%;
                            margin-bottom: 10px;
                        }
                        .invoice-details td {
                            padding: 2px 5px;
                        }
                        .invoice-title {
                            text-align: center;
                            font-size: 16px;
                            font-weight: bold;
                            margin: 10px 0;
                        }
                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }
                        .items-table th, .items-table td {
                            border-top: 1px solid #ddd;
                            border-bottom: 1px solid #ddd;
                            padding: 5px;
                            text-align: left;
                        }
                        .items-table .amount {
                            text-align: right;
                        }
                        .totals-table {
                            width: 100%;
                            margin: 10px 0;
                        }
                        .totals-table td {
                            padding: 2px 5px;
                        }
                        .totals-table .label {
                            text-align: right;
                        }
                        .totals-table .dots {
                            border-bottom: 1px dotted #ccc;
                            position: relative;
                            width: 100%;
                        }
                        .totals-table .value {
                            text-align: right;
                            width: 80px;
                        }
                        .payment-section {
                            margin: 15px 0;
                        }
                        .payment-title {
                            font-weight: bold;
                            margin-bottom: 5px;
                        }
                        .payment-table th, .payment-table td {
                            border-top: 1px solid #ddd;
                            border-bottom: 1px solid #ddd;
                            padding: 5px;
                            text-align: left;
                        }
                        .qr-section {
                            text-align: center;
                            margin: 20px auto;
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            justify-content: center;
                            width: 100%;
                        }
                        .qr-section #qrcode {
                            margin: 10px auto;
                        }
                        .qr-section p {
                            margin-bottom: 10px;
                        }
                        .barcode-section {
                            text-align: center;
                            margin: 20px 0;
                        }
                        .footer-text {
                            text-align: center;
                            margin-top: 10px;
                            font-size: 11px;
                        }
                        .text-right {
                            text-align: right;
                        }
                        .text-center {
                            text-align: center;
                        }
                        .button-container {
                            display: flex;
                            flex-direction: column;
                            gap: 10px;
                            margin-top: 20px;
                        }
                        .button {
                            padding: 10px;
                            text-align: center;
                            border-radius: 5px;
                            cursor: pointer;
                            font-weight: bold;
                            color: white;
                        }
                        .print-btn {
                            background-color: #17a2b8;
                        }
                        .email-btn {
                            background-color: #28a745;
                        }
                        .back-btn {
                            background-color: #6c757d;
                            color: white;
                            padding: 8px 15px;
                            text-decoration: none;
                            display: inline-block;
                            margin-top: 10px;
                            border-radius: 5px;
                            font-size: 12px;
                        }
                        .tax-table {
                            width: 100%;
                            margin: 10px 0;
                            border-collapse: collapse;
                        }
                        .tax-table th, .tax-table td {
                            border-top: 1px solid #ddd;
                            border-bottom: 1px solid #ddd;
                            padding: 5px;
                            text-align: left;
                        }
                        .warranty-text {
                            text-align: center;
                            font-size: 11px;
                            margin: 10px 0;
                        }
                        @media print {
                            .button-container, .back-btn {
                                display: none;
                            }
                            body {
                                padding: 0;
                                margin: 0;
                            }
                        }
                    </style>
                    <!-- Load barcode library first -->
                    <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>
                    <!-- Multiple QR code libraries for fallback -->
                    <script>
                        // We'll try multiple QR code libraries to ensure we have one that works
                        function loadScript(url, callback) {
                            var script = document.createElement('script');
                            script.type = 'text/javascript';
                            script.src = url;
                            script.onload = function() {
                                console.log('QRCode library loaded successfully from: ' + url);
                                callback(true);
                            };
                            script.onerror = function() {
                                console.log('Failed to load QRCode from: ' + url);
                                callback(false);
                            };
                            document.head.appendChild(script);
                        }
                        
                        // Try to load QR code libraries in order
                        var qrLibraries = [
                            '/assets/js/qrcode.min.js',
                            'assets/js/qrcode.min.js',
                            '../assets/js/qrcode.min.js',
                            'https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js',
                            'https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js'
                        ];
                        
                        var qrLibraryIndex = 0;
                        
                        function tryLoadQRLibrary() {
                            if (qrLibraryIndex >= qrLibraries.length) {
                                // All libraries failed, fall back to image
                                generateQRAsImage();
                                return;
                            }
                            
                            loadScript(qrLibraries[qrLibraryIndex], function(success) {
                                if (success) {
                                    generateQRCode();
                                } else {
                                    qrLibraryIndex++;
                                    tryLoadQRLibrary();
                                }
                            });
                        }
                        
                        function generateQRAsImage() {
                            // If all QR libraries fail, we'll generate a QR code via an API
                            var qrContainer = document.getElementById('qrcode');
                            if (qrContainer) {
                                var amount = "${formatNumber(payableAmount)}";
                                var reference = "${paymentReference}";
                                var storeName = "${storeName}";
                                
                                var img = document.createElement('img');
                                img.src = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=" + 
                                    encodeURIComponent("${upiId}") + 
                                    "&pn=" + encodeURIComponent(storeName) +
                                    "&am=" + amount + 
                                    "&cu=INR" +
                                    "&tn=" + encodeURIComponent("Order Payment - " + reference);
                                img.alt = "UPI QR Code";
                                img.style.width = '150px';
                                img.style.margin = '0 auto';
                                img.style.display = 'block';
                                
                                qrContainer.innerHTML = '';
                                qrContainer.appendChild(img);
                            }
                        }
                        
                        function generateQRCode() {
                            var qrContainer = document.getElementById('qrcode');
                            if (!qrContainer) return;
                            
                            var amount = "${formatNumber(payableAmount)}";
                            var reference = "${paymentReference}";
                            var storeName = "${storeName}";
                            
                            try {
                                console.log("Generating QR code with amount: " + amount + " CTN: " + reference + " Source: Browser");
                                
                                // Clear the container
                                qrContainer.innerHTML = '';
                                qrContainer.style.display = 'flex';
                                qrContainer.style.justifyContent = 'center';
                                qrContainer.style.alignItems = 'center';
                                qrContainer.style.margin = '0 auto';
                                
                                // Create UPI URL with fixed amount - match format in checkout
                                var upiUrl = "upi://pay?pa=" + encodeURIComponent("${upiId}") + 
                                    "&pn=" + encodeURIComponent(storeName) +
                                    "&am=" + amount + 
                                    "&cu=INR" +
                                    "&tn=" + encodeURIComponent("Order Payment - " + reference);
                                
                                // Check which QR library is available
                                if (typeof QRCode !== 'undefined') {
                                    // Using qrcode.js library
                                    new QRCode(qrContainer, {
                                        text: upiUrl,
                                        width: 150,
                                        height: 150
                                    });
                                } else if (typeof window.QRCode !== 'undefined') {
                                    // Alternative way to access QRCode
                                    new window.QRCode(qrContainer, {
                                        text: upiUrl,
                                        width: 150,
                                        height: 150
                                    });
                                } else {
                                    // Fall back to image
                                    generateQRAsImage();
                                }
                            } catch (e) {
                                console.error("Error generating QR code:", e);
                                generateQRAsImage();
                            }
                        }
                        
                        // Generate barcode
                        function generateBarcode() {
                            var barcodeElement = document.getElementById('barcode');
                            if (barcodeElement) {
                                try {
                                    JsBarcode("#barcode", "${invoiceId}", {
                                        format: "CODE128",
                                        width: 2,
                                        height: 50,
                                        displayValue: true
                                    });
                                } catch (e) {
                                    console.error("Error generating barcode:", e);
                                    // Create a simple text fallback
                                    barcodeElement.textContent = "${invoiceId}";
                                }
                            }
                        }
                        
                        // On document load
                        window.onload = function() {
                            // Only try to load QR library if UPI QR is enabled
                            if (window.store && window.store.show_upi_qr == 1) {
                                tryLoadQRLibrary();
                            }
                            generateBarcode();
                        };
                    </script>
                </head>
                <body>
                    <div class="invoice-container">
                        <div class="logo-container">
                            <img class="logo" src="${logoUrl ? logoUrl : logoBase64}" alt="Store Logo">
                        </div>
                        <div class="store-name">${storeName}</div>
                        <div class="store-address">athani</div>
                        <div class="store-contact">Mobile: ${storeMobile}${storeEmail ? ' | Email: ' + storeEmail : ''}</div>
                        
                        <table class="invoice-details">
                            <tr>
                                <td width="25%"><strong>Invoice ID:</strong></td>
                                <td width="25%">${invoiceId}</td>
                                <td width="25%"></td>
                                <td width="25%"></td>
                            </tr>
                            <tr>
                                <td><strong>VAT Reg:</strong></td>
                                <td>${vatReg}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><strong>Date:</strong></td>
                                <td>${createdAt}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><strong>GST Reg:</strong></td>
                                <td>${gstReg}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><strong>Customer Name:</strong></td>
                                <td>${customerName}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><strong>Phone:</strong></td>
                                <td>${customerContact}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><strong>Address:</strong></td>
                                <td>${customerAddress}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><strong>GTIN:</strong></td>
                                <td>${customerGTIN}</td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                        
                        <div class="invoice-title">INVOICE</div>
                        
                        <table class="items-table">
                            <thead>
                                <tr>
                                    <th width="5%">SL</th>
                                    <th width="45%">Name</th>
                                    <th width="15%">Qty</th>
                                    <th width="15%">Price</th>
                                    <th width="20%" style="text-align:right">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${scope.invoiceItems.map((item, index) => {
                                    const itemQty = parseFloat(item.item_quantity || 0);
                                    const itemPrice = parseFloat(item.item_price || 0);
                                    const itemAmount = itemQty * itemPrice;
                                    
                                    return `
                                    <tr>
                                        <td>${index + 1}</td>
                                        <td>${item.item_name}</td>
                                        <td>${itemQty.toFixed(2)}</td>
                                        <td>${itemPrice.toFixed(2)}</td>
                                        <td style="text-align:right">${itemAmount.toFixed(2)}</td>
                                    </tr>`;
                                }).join('')}
                            </tbody>
                        </table>
                        
                        <table class="totals-table">
                            <tr>
                                <td width="70%" class="label">Total Amt:</td>
                                <td width="10%" class="dots">..............................</td>
                                <td width="20%" class="value">${formatNumber(subtotal)}</td>
                            </tr>
                            <tr>
                                <td class="label">Order Tax:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(orderTax)}</td>
                            </tr>
                            <tr>
                                <td class="label">Discount:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(discountAmount)}</td>
                            </tr>
                            <tr>
                                <td class="label">Shipping Chrg:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(shippingAmount)}</td>
                            </tr>
                            <tr>
                                <td class="label">Others Chrg:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(othersCharge)}</td>
                            </tr>
                            <tr>
                                <td class="label">Previous Due:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(previousDue)}</td>
                            </tr>
                            <tr>
                                <td class="label">Total Due:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(payableAmount)}</td>
                            </tr>
                            <tr>
                                <td class="label">Amount Paid:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(paidAmount)}</td>
                            </tr>
                            <tr>
                                <td class="label">Prev. Due Paid:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(prevDuePaid)}</td>
                            </tr>
                            <tr>
                                <td class="label">Change:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(changeAmount)}</td>
                            </tr>
                            <tr>
                                <td class="label">Due:</td>
                                <td class="dots">..............................</td>
                                <td class="value">${formatNumber(dueAmount)}</td>
                            </tr>
                        </table>
                        
                        <div class="text-center">
                            <em>In Text: Five only</em>
                        </div>
                        
                        <div class="payment-section">
                            <div class="payment-title">Payments</div>
                            <table class="payment-table">
                                <thead>
                                    <tr>
                                        <th width="10%">SL</th>
                                        <th width="60%">Payment Method</th>
                                        <th width="15%">Amount</th>
                                        <th width="15%">Balance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>${paymentMethod} by Your Name<br>on ${createdAt}</td>
                                        <td>${formatNumber(paidAmount)}</td>
                                        <td>0.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="tax-section">
                            <div class="payment-title">Tax Information</div>
                            <table class="tax-table">
                                <thead>
                                    <tr>
                                        <th width="35%">Name</th>
                                        <th width="25%">Code</th>
                                        <th width="20%">Qty</th>
                                        <th width="20%">Tax Amt.</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>No Tax</td>
                                        <td>no_tax</td>
                                        <td>1.00</td>
                                        <td>0.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="barcode-section">
                            <svg id="barcode"></svg>
                        </div>
                        
                        ${window.store && window.store.show_upi_qr == 1 ? `
                        <div class="qr-section">
                            <p>Scan to pay via UPI (${upiId})</p>
                            <div id="qrcode"></div>
                        </div>` : ''}
                        
                        <div class="warranty-text">
                            Sold product No Claim. No Change. New product One Month Warranty.<br>
                            Thank you for choosing us!
                        </div>
                        
                        <div class="footer-text">
                            ${scope.invoiceInfo.invoice_note ? scope.invoiceInfo.invoice_note : ''}
                        </div>
                        
                        <div class="button-container">
                            <div class="button print-btn" onclick="window.print();">
                                <i class="fa fa-print"></i> Print
                            </div>
                            <div class="button email-btn">
                                <i class="fa fa-envelope"></i> Send Email
                            </div>
                        </div>
                        
                        <div class="text-center">
                            <a href="#" class="back-btn" onclick="window.close()">← Back To Pos</a>
                        </div>
                    </div>
                </body>
                </html>
                `;
                
                // Open a new window and write the invoice HTML to it
                var printWindow = window.open('', '_blank', 'height=600,width=800');
                printWindow.document.write(invoiceHTML);
                printWindow.document.close();
                
                // Wait for resources to load then print
                setTimeout(function() {
                    printWindow.print();
                }, 1000);
                
            } catch (e) {
                console.error("Error generating PDF receipt:", e);
                window.toastr.error("Failed to generate receipt: " + e.message);
            }
        };
        
        // Monkey patch for PrintReceiptModal to handle customer_mobile properly
        window.monkeyPatchPrintReceiptModal = function(directScope) {
            try {
                // First try direct printing
                $.ajax({
                    url: window.baseUrl + "_inc/print.php",
                    type: "POST",
                    data: directScope,
                    dataType: "json",
                    beforeSend: function() {
                        console.log("Sending print request...");
                    },
                    success: function(response) {
                        if (response.error) {
                            window.toastr.error(response.error, "Error!");
                            // If printing fails, generate PDF receipt as fallback
                            window.generatePDFReceipt(directScope);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Print request failed:", xhr, status, error);
                        // If AJAX request fails, generate PDF receipt as fallback
                        window.generatePDFReceipt(directScope);
                    }
                });
            } catch (e) {
                console.error("Printing error:", e);
                window.toastr.error("Error printing receipt: " + e.message, "Error!");
                // If any error occurs, generate PDF receipt as fallback
                window.generatePDFReceipt(directScope);
            }
        };
    }
    
    // Start the patch when document is ready
    if (document.readyState === "complete" || document.readyState === "interactive") {
        setTimeout(initPatch, 100);
    } else {
        document.addEventListener("DOMContentLoaded", function() {
            setTimeout(initPatch, 100);
        });
    }
})();