<?php
// Get store name for payment description
$store_name = get_store_name(store_id());
$store_name_encoded = urlencode($store_name);
?>
<div class="panel panel-default mt-5">
    <div class="panel-body">
        <div class="text-center">
            <h4>Debug: UPI Payment Section Loaded</h4>
            <div id="debug-info" style="background: #f5f5f5; padding: 10px; margin: 10px 0; text-align: left;">
                <p>Store Name: <?php echo $store_name; ?></p>
                <p>Initial Amount: <span id="debug-amount">Loading...</span></p>
            </div>

            <div id="upi-qr-code">
                <p>Debug: QR Code Container</p>
            </div>
            <p class="mt-2">Amount to pay: ₹<span id="upi-amount-display">{{ paidAmount }}</span></p>
            
            <div class="form-group mt-3">
                <label for="upi_transaction_id" class="control-label">
                    <?php echo trans('text_transaction_id'); ?> <span class="text-danger">*</span>
                </label>
                <div class="col-sm-12">
                    <input type="text" id="upi_transaction_id" name="payment_details[upi_transaction_id]" 
                        placeholder="Enter UPI Transaction ID" class="form-control" autocomplete="off" required>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
console.log('Debug: UPI Payment Script Started');

document.addEventListener('DOMContentLoaded', function() {
    console.log('Debug: DOM Content Loaded');
    
    // Debug: Log initial elements
    console.log('Debug: paid-amount element:', document.getElementById('paid-amount'));
    console.log('Debug: upi-qr-code element:', document.getElementById('upi-qr-code'));
    
    function updateDebugInfo() {
        var paidAmountElement = document.getElementById('paid-amount');
        var debugAmount = document.getElementById('debug-amount');
        var amount = paidAmountElement ? paidAmountElement.value : 'Element not found';
        debugAmount.textContent = amount;
        console.log('Debug: Current amount:', amount);
    }

    function generateQRCode(amount) {
        console.log('Debug: Generating QR code for amount:', amount);
        
        var qrContainer = document.getElementById('upi-qr-code');
        var amountDisplay = document.getElementById('upi-amount-display');
        
        // Update debug display
        qrContainer.innerHTML = '<div style="border: 1px solid #ccc; padding: 10px; margin: 10px;">' +
            '<p>Debug: QR Code would be generated for amount: ' + amount + '</p>' +
            '<p>Debug: UPI URL would be: upi://pay?pn=' + encodeURIComponent('<?php echo $store_name; ?>') + 
            '&tn=Payment&am=' + amount + '&cu=INR</p>' +
            '</div>';
        
        if (amountDisplay) {
            amountDisplay.textContent = amount;
        }
        
        updateDebugInfo();
    }

    // Initial debug info
    updateDebugInfo();

    // Try to get initial amount
    var initialAmount = document.getElementById('paid-amount');
    if (initialAmount) {
        console.log('Debug: Initial amount found:', initialAmount.value);
        generateQRCode(initialAmount.value);
    } else {
        console.log('Debug: Could not find paid-amount element');
    }

    // Listen for amount changes
    document.addEventListener('input', function(e) {
        if (e.target.matches('input[placeholder="Input An Amount"]')) {
            console.log('Debug: Custom amount input detected:', e.target.value);
            var amount = e.target.value.trim() || (initialAmount ? initialAmount.value : '0');
            generateQRCode(amount);
        }
    });

    // Listen for paid-amount changes
    if (initialAmount) {
        initialAmount.addEventListener('input', function() {
            console.log('Debug: Paid amount changed:', this.value);
            generateQRCode(this.value);
        });
    }

    // Listen for transaction ID input
    var transactionInput = document.getElementById('upi_transaction_id');
    if (transactionInput) {
        transactionInput.addEventListener('change', function() {
            if (this.value.trim()) {
                // Show success view
                document.getElementById('upi-qr-code').style.display = 'none';
                document.getElementById('upi-qr-view').style.display = 'none';
                document.getElementById('upi-success-view').style.display = 'block';
                document.getElementById('success-transaction-id').textContent = this.value;
            }
        });
    }
});
</script> 