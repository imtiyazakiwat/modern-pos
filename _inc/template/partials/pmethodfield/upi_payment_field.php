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
<script>
// Dynamically load QRCode library with fallbacks
(function loadQRCodeLibrary() {
    var qrLibraryLoaded = false;
    var loadAttempts = 0;
    var maxAttempts = 2; // Limit attempts to prevent freezing
    
    // Try different paths to find the library
    var paths = [
        '../assets/itsolution24/js/qrcode/qrcode.min.js',
        'https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js'
    ];
    
    function tryLoadScript(index) {
        if (qrLibraryLoaded) {
            return;
        }
        
        if (index >= paths.length || loadAttempts >= maxAttempts) {
            console.error("Failed to load QRCode library, using fallback");
            $('#upi-qr-code').html('<p class="text-warning">QR Code unavailable. Please enter transaction ID manually.</p>');
            return;
        }
        
        loadAttempts++;
        var script = document.createElement('script');
        script.src = paths[index];
        
        // Add timeout to prevent hanging
        var timeout = setTimeout(function() {
            console.warn("Timeout loading QRCode from: " + paths[index]);
            tryLoadScript(index + 1);
        }, 3000);
        
        script.onload = function() {
            clearTimeout(timeout);
            qrLibraryLoaded = true;
            console.log("[UPI QR] QRCode library loaded successfully from: " + paths[index]);
            // Don't call generateUpiQrCode here - let document.ready handle it
        };
        script.onerror = function() {
            clearTimeout(timeout);
            console.warn("Failed to load QRCode from: " + paths[index]);
            setTimeout(function() {
                tryLoadScript(index + 1);
            }, 100);
        };
        document.head.appendChild(script);
    }
    
    // Start loading with a small delay to prevent blocking
    setTimeout(function() {
        tryLoadScript(0);
    }, 100);
})();
</script>

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

// Track if generation is in progress to prevent multiple calls
var qrGenerationInProgress = false;
var qrGenerationCount = 0;
var qrCodeGenerated = false;

// Function to generate UPI QR code directly in browser
function generateUpiQrCode() {
    console.log('[UPI QR] generateUpiQrCode called, count:', ++qrGenerationCount);
    
    try {
        // Prevent multiple simultaneous generations
        if (qrGenerationInProgress) {
            console.log('[UPI QR] Generation already in progress, skipping');
            return;
        }
        
        // Prevent regeneration if already generated (unless explicitly refreshed)
        if (qrCodeGenerated && qrGenerationCount > 1) {
            console.log('[UPI QR] QR code already generated, skipping duplicate call');
            return;
        }
        
        // Check if the QR code container still exists (modal not closed)
        if ($('#upi-qr-code').length === 0) {
            console.log('[UPI QR] Container not found, modal likely closed');
            return;
        }
        
        qrGenerationInProgress = true;
        console.log('[UPI QR] Starting generation process');
        
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
        
        console.log("[UPI QR] Generating with amount:", formattedAmount, "CTN:", ctn, "Source:", scopeAccess);
        
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
        console.log('[UPI QR] Creating QRCode object');
        new QRCode(document.getElementById("upi-qr-code"), {
            text: upiUrl,
            width: 200,
            height: 200,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H
        });
        
        console.log('[UPI QR] QR code generated successfully');
        qrCodeGenerated = true;
        qrGenerationInProgress = false;
    } catch (e) {
        console.error("[UPI QR] Error:", e);
        $('#upi-qr-code').html('<p class="text-danger">Error: ' + e.message + '</p>');
        qrGenerationInProgress = false;
    }
}

// Use a namespace for events to allow proper cleanup
var upiEventNamespace = '.upiQrCode' + Date.now();
var qrCodeInitialized = false;
var eventListenersAttached = false;

console.log('[UPI QR] Event namespace created:', upiEventNamespace);

// Watch for changes in the paid amount
$(document).on('input' + upiEventNamespace, '#paid-amount', function() {
    console.log('[UPI QR] Paid amount changed');
    // Only regenerate if QR code container exists
    if ($('#upi-qr-code').length > 0) {
        console.log('[UPI QR] Scheduling regeneration in 500ms');
        setTimeout(generateUpiQrCode, 500);
    } else {
        console.log('[UPI QR] Container not found, skipping regeneration');
    }
});

// Refresh QR code button
$(document).on('click' + upiEventNamespace, '#refresh-upi-qr', function() {
    console.log('[UPI QR] Refresh button clicked');
    if ($('#upi-qr-code').length > 0) {
        $('#upi-qr-code').html('<p>Refreshing QR code...</p>');
        qrCodeGenerated = false; // Allow regeneration
        qrGenerationInProgress = false;
        setTimeout(generateUpiQrCode, 100);
    }
});

// Show debug info when pressing Ctrl+D (for debugging purposes)
$(document).on('keydown' + upiEventNamespace, function(e) {
    if (e.ctrlKey && e.keyCode === 68) { // Ctrl+D
        if ($('#upi-debug-info').length > 0) {
            $('#upi-debug-info').toggle();
        }
        return false;
    }
});

// Clean up event listeners when modal is closed
$(document).on('hidden.bs.modal', '.modal', function() {
    console.log('[UPI QR] Modal closed, cleaning up');
    // Remove all UPI-related event listeners
    $(document).off(upiEventNamespace);
    qrCodeInitialized = false;
    qrGenerationInProgress = false;
    qrCodeGenerated = false;
    console.log('[UPI QR] Event listeners cleaned up, flags reset');
});

// Also clean up when modal is dismissed
$(document).on('hide.bs.modal', '.modal', function() {
    console.log('[UPI QR] Modal hiding');
    qrGenerationInProgress = false;
});

// Initialize QR code generation when the template is loaded
$(document).ready(function() {
    console.log('[UPI QR] Document ready, qrCodeInitialized:', qrCodeInitialized);
    
    // Wait for QR library to load, then generate
    var checkLibraryInterval = setInterval(function() {
        if (typeof QRCode !== 'undefined' && !qrCodeInitialized && $('#upi-qr-code').length > 0) {
            clearInterval(checkLibraryInterval);
            qrCodeInitialized = true;
            console.log('[UPI QR] Library loaded, generating QR code');
            setTimeout(generateUpiQrCode, 500);
        }
    }, 100);
    
    // Stop checking after 10 seconds
    setTimeout(function() {
        clearInterval(checkLibraryInterval);
        if (!qrCodeInitialized) {
            console.log('[UPI QR] Library load timeout, QR code not generated');
        }
    }, 10000);
});
</script> 