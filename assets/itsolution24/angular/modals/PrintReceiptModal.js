window.angularApp.factory("PrintReceiptModal", ["API_URL", "window", "jQuery", "$http", "$rootScope", function (API_URL, window, $, $http, $scope) {
    return function(data) {
        // If data is an Angular scope (legacy support), use it directly
        var $scope = data;
        
        // If data is our new printData object format
        if (data && !data.$id && !data.$parent && data.invoice_id) {
            // Create a temporary scope-like object
            $scope = {
                invoiceId: data.invoice_id,
                invoiceInfo: {
                    invoice_id: data.invoice_id,
                    created_at: data.date || new Date().toLocaleDateString(),
                    by: data.created_by || 'Admin',
                    customer_name: data.customer_name || 'Walk-in Customer',
                    customer_mobile: data.customer_mobile || '',
                    customer_email: '',
                    payable_amount: data.payable_amount || 0,
                    paid_amount: data.paid_amount || 0,
                    due: data.due || 0,
                    balance: data.change || 0,
                    discount_amount: data.discount_amount || 0,
                    order_tax: data.tax_amount || 0,
                    shipping_amount: data.shipping_amount || 0,
                    others_charge: data.others_charge || 0,
                    previous_due: data.previous_due || 0,
                    prev_due_paid: 0,
                    return_amount: 0,
                    invoice_note: ''
                },
                invoiceItems: data.items || []
            };
        }
        
        // Check if required data exists
        if (!$scope || !$scope.invoiceInfo) {
            console.error("Invalid data passed to PrintReceiptModal");
            return;
        }

        // Safety check for invoiceInfo properties
        if (!$scope.invoiceInfo) {
            $scope.invoiceInfo = {};
        }

        var customerContact = '';
        if ($scope.invoiceInfo && typeof $scope.invoiceInfo === 'object') {
            if ($scope.invoiceInfo.customer_mobile && $scope.invoiceInfo.customer_mobile !== "undefined") {
                customerContact = $scope.invoiceInfo.customer_mobile;
            } else if ($scope.invoiceInfo.mobile_number && $scope.invoiceInfo.mobile_number !== "undefined") {
                customerContact = $scope.invoiceInfo.mobile_number;
            } else if ($scope.invoiceInfo.customer_email && $scope.invoiceInfo.customer_email !== "undefined") {
                customerContact = $scope.invoiceInfo.customer_email;
            }
        }

        // Ensure window.store exists
        if (!window.store) {
            window.store = {
                name: 'Store',
                address: '',
                mobile: ''
            };
        }

        var receipt_data = {};
        receipt_data.store_name = (window.store.name || 'Store') + "\n";

        receipt_data.header = "";
        receipt_data.header += (window.store.address || '') + "\n";
        receipt_data.header += (window.store.mobile || '') + "\n";
        receipt_data.header += "\n";

        receipt_data.info = "";
        receipt_data.info += "Date:" + ($scope.invoiceInfo.created_at || '') + "\n";
        receipt_data.info += "Invoice ID:" + ($scope.invoiceInfo.invoice_id || '') + "\n";
        receipt_data.info += "Created By:" + ($scope.invoiceInfo.by || '') + "\n";
        receipt_data.info += "\n";
        receipt_data.info += "Customer:" + ($scope.invoiceInfo.customer_name || 'Walk-in Customer') + "\n";
        receipt_data.info += "Contact:" + (customerContact || '') + "\n";
        receipt_data.info += "\n";

        receipt_data.items = "";
        if ($scope.invoiceItems && Array.isArray($scope.invoiceItems)) {
            window.angular.forEach($scope.invoiceItems, function($row, key) {
                receipt_data.items += "#" + (key+1) + " " + ($row.item_name || '') + "\n";
                var quantity = parseInt($row.item_quantity || 0);
                var price = parseFloat($row.item_price || 0);
                receipt_data.items += quantity + " x " + price.toFixed(2) + "  =  " + (quantity * price).toFixed(2) + "\n";
            });
        }

        // Use default values of 0 for all numeric fields to avoid NaN
        var payable_amount = parseFloat($scope.invoiceInfo.payable_amount || 0);
        var previous_due = parseFloat($scope.invoiceInfo.previous_due || 0);
        var paid_amount = parseFloat($scope.invoiceInfo.paid_amount || 0);
        var prev_due_paid = parseFloat($scope.invoiceInfo.prev_due_paid || 0);
        var balance = parseFloat($scope.invoiceInfo.balance || 0);
        var return_amount = parseFloat($scope.invoiceInfo.return_amount || 0);
        var due = parseFloat($scope.invoiceInfo.due || 0);
        
        var totalAmount = payable_amount + previous_due;
        var paidAmount = paid_amount + prev_due_paid + (balance - return_amount);
        var dueAmount = (due + previous_due) - prev_due_paid;

        receipt_data.totals = "";
        receipt_data.totals += "\n";
        receipt_data.totals += "Subtotal: " + payable_amount.toFixed(2) + "\n";
        receipt_data.totals += "Order Tax: " + parseFloat($scope.invoiceInfo.order_tax || 0).toFixed(2) + "\n";
        receipt_data.totals += "Discount:" + parseFloat($scope.invoiceInfo.discount_amount || 0).toFixed(2) + "\n";
        receipt_data.totals += "Shipping Chrg.:" + parseFloat($scope.invoiceInfo.shipping_amount || 0).toFixed(2) + "\n";
        receipt_data.totals += "Others Chrg.:" + parseFloat($scope.invoiceInfo.others_charge || 0).toFixed(2) + "\n";
        receipt_data.totals += "Previous Due:" + previous_due.toFixed(2) + "\n";
        receipt_data.totals += "Amount Total:" + totalAmount.toFixed(2) + "\n";
        receipt_data.totals += "Amount Paid:" + paidAmount.toFixed(2) + "\n";
        receipt_data.totals += "Due Amount:" + dueAmount.toFixed(2) + "\n";
        receipt_data.totals += "Change:" + balance.toFixed(2) + "\n";

        receipt_data.footer = "";
        if ($scope.invoiceInfo.invoice_note) {
            receipt_data.footer += $scope.invoiceInfo.invoice_note + "\n\n";
        }  else {
            receipt_data.footer += "Thank you for choosing us.";
        }

        // Ensure window.printer exists
        if (!window.printer) {
            console.error("Printer configuration not found");
            window.toastr.error("Printer configuration not found", "Error!");
            return;
        }

        var socket_data = {
            'printer': window.printer,
            'logo': '',
            'text': receipt_data,
            'cash_drawer': '',
        };
        
        try {
            $.get(window.baseUrl+'_inc/print.php', {data: JSON.stringify(socket_data)})
                .fail(function(xhr, status, error) {
                    console.error("Print error:", error);
                    window.toastr.error("Error printing receipt: " + error, "Error!");
                });
        } catch (e) {
            console.error("Print exception:", e);
            window.toastr.error("Error printing receipt: " + e.message, "Error!");
        }
    };
}]);