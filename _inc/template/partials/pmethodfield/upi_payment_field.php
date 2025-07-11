<?php
$store_name = store('name');
?>
<div class="panel panel-default mt-5">
    <div class="panel-body">
        <div class="text-center">
            <!-- QR code will be generated here after page loads -->
            <div id="upi-qr-code">
                <p>Generating QR code...</p>
            </div>
            <p class="mt-2">Amount to pay: ₹<span id="upi-amount-display">0.00</span></p>
            <button type="button" class="btn btn-sm btn-info" id="refresh-upi-qr" style="margin-top: 10px;">
                <i class="fa fa-refresh"></i> Refresh QR Code
            </button>
            <p class="text-success"><small>QR code has fixed amount - no manual entry needed in UPI app</small></p>
            <p class="text-muted"><small>Transaction Reference: <span id="ctn-display"></span></small></p>
            
            <div class="form-group mt-3">
                <label for="upi_transaction_id" class="control-label">
                    <?php echo trans('text_transaction_id'); ?> <span class="text-danger">*</span>
                </label>
                <div class="col-sm-12">
                    <input type="text" id="upi_transaction_id" name="payment_details" class="form-control" placeholder="Enter UPI Transaction ID" required>
                    <input type="hidden" id="upi_ctn" name="payment_details_ctn">
                </div>
            </div>
            
            <!-- Debug info - hidden in production -->
            <div id="upi-debug-info" style="display: none; margin-top: 20px; text-align: left; font-size: 12px; background: #f9f9f9; padding: 10px; border-radius: 5px;">
                <p><strong>Debug Information:</strong></p>
                <p>UPI URL: <span id="upi-debug-url"></span></p>
                <p>Amount: <span id="upi-debug-amount"></span></p>
                <p>CTN: <span id="upi-debug-ctn"></span></p>
                <p>Scope Access: <span id="upi-debug-scope"></span></p>
            </div>
        </div>
    </div>
</div>

<!-- Include local QRCode.js library -->
<script src="/modernpos/assets/js/qrcode.min.js"></script>

<script type="text/javascript">
// Function to get amount from various sources
function getPaymentAmount() {
    var amount = 0;
    var scopeAccess = "Failed";
    
    // Try to get from paid-amount input first (most reliable)
    try {
        var paidAmountInput = document.getElementById('paid-amount');
        if (paidAmountInput && paidAmountInput.value && !isNaN(parseFloat(paidAmountInput.value))) {
            amount = parseFloat(paidAmountInput.value);
            scopeAccess = "paid-amount input";
            return { amount: amount, source: scopeAccess };
        }
    } catch (e) {
        console.error("Error getting amount from input:", e);
    }
    
    // Try Angular scope
    if (window.angular) {
        try {
            // Find any element with ng-controller and get its scope
            var element = angular.element(document.querySelector('[ng-controller]'));
            if (element.scope && element.scope()) {
                var scope = element.scope();
                if (scope.totalPayable && !isNaN(parseFloat(scope.totalPayable))) {
                    amount = parseFloat(scope.totalPayable);
                    scopeAccess = "Angular scope";
                    return { amount: amount, source: scopeAccess };
                }
            }
        } catch (e) {
            console.error("Error getting amount from Angular scope:", e);
        }
    }
    
    // Default fallback
    return { amount: 100, source: "Default fallback" };
}

// Function to generate UPI QR code directly in browser
function generateUpiQrCode() {
    try {
        // Get payment amount
        var amountInfo = getPaymentAmount();
        var amount = amountInfo.amount;
        var scopeAccess = amountInfo.source;
        
        var formattedAmount = parseFloat(amount).toFixed(2);
        $('#upi-amount-display').text(formattedAmount);
        $('#upi-debug-amount').text(formattedAmount);
        $('#upi-debug-scope').text(scopeAccess);
        
        // Generate a unique transaction reference
        var ctn = 'INV' + Date.now() + Math.floor(Math.random() * 9000 + 1000);
        $('#ctn-display').text(ctn);
        $('#upi_ctn').val(ctn);
        $('#upi-debug-ctn').text(ctn);
        
        console.log("Generating QR code with amount:", formattedAmount, "CTN:", ctn, "Source:", scopeAccess);
        
        // Create UPI URL with fixed amount
        var upiId = "hanamantmokashi@ybl"; // Change this to your actual UPI ID
        var storeName = "<?php echo addslashes($store_name); ?>";
        
        var upiUrl = "upi://pay?pa=" + encodeURIComponent(upiId) + 
                    "&pn=" + encodeURIComponent(storeName) + 
                    "&am=" + formattedAmount + 
                    "&cu=INR" + 
                    "&tn=" + encodeURIComponent("Order Payment - " + ctn);
        
        $('#upi-debug-url').text(upiUrl);
        
        // Clear existing QR code
        $('#upi-qr-code').empty();
        $('#upi-qr-code').css({
            'display': 'flex',
            'justify-content': 'center',
            'align-items': 'center',
            'margin': '0 auto'
        });
        
        // Generate QR code using qrcode.js library
        new QRCode(document.getElementById("upi-qr-code"), {
            text: upiUrl,
            width: 200,
            height: 200,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H
        });
    } catch (e) {
        console.error("Main function error:", e);
        $('#upi-qr-code').html('<p class="text-danger">Error: ' + e.message + '</p>');
    }
}

// Watch for changes in the paid amount
$(document).on('input', '#paid-amount', function() {
    // Regenerate QR code when amount changes
    setTimeout(generateUpiQrCode, 500);
});

// Refresh QR code button
$(document).on('click', '#refresh-upi-qr', function() {
    $('#upi-qr-code').html('<p>Refreshing QR code...</p>');
    setTimeout(generateUpiQrCode, 100);
});

// Show debug info when pressing Ctrl+D (for debugging purposes)
$(document).keydown(function(e) {
    if (e.ctrlKey && e.keyCode === 68) { // Ctrl+D
        $('#upi-debug-info').toggle();
        return false;
    }
});

// Initialize QR code generation when the template is loaded
$(document).ready(function() {
    // Wait for everything to be initialized
    setTimeout(generateUpiQrCode, 1000);
});
</script> 