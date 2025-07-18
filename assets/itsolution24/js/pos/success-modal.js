// Override the default SweetAlert success message
(function() {
    // Store the original swal function
    var originalSwal = window.swal;
    
    // Override the swal function
    window.swal = function() {
        // If it's a success message
        if (arguments.length === 3 && arguments[2] === "success") {
            // Extract invoice ID from the message if it exists
            var text = arguments[1];
            var invoiceId = null;
            
            // First try to extract using the ID: pattern
            var idMatch = text.match(/ID:\s*(\d+(?:\/\d+)?)/);
            if (idMatch && idMatch[1]) {
                invoiceId = idMatch[1];
            } 
            // If not found, try to find any numeric ID in the text
            else if (/invoice|order/i.test(text)) {
                var numMatch = text.match(/(\d+(?:\/\d+)?)/);
                if (numMatch && numMatch[1]) {
                    invoiceId = numMatch[1];
                }
            }
            
            console.log("Success modal detected invoice ID:", invoiceId);

            return originalSwal({
                title: "Success",
                text: text,
                icon: "success",
                buttons: {
                    view: {
                        text: "View Invoice",
                        value: "view",
                        visible: !!invoiceId,
                        className: "btn-info"
                    },
                    print: {
                        text: "Print Invoice",
                        value: "print",
                        visible: !!invoiceId,
                        className: "btn-success"
                    },
                    ok: {
                        text: "OK",
                        value: "ok",
                        visible: true,
                        className: "btn-default"
                    }
                }
            }).then((value) => {
                if (value === "view" && invoiceId) {
                    // Redirect to invoice view page
                    console.log("Redirecting to view_invoice.php with ID:", invoiceId);
                    
                    // Get the redirect target from the form if available
                    var redirectPage = "view_invoice.php";
                    var checkoutForm = document.getElementById('checkout-form');
                    if (checkoutForm) {
                        var formRedirect = checkoutForm.getAttribute('data-redirect');
                        if (formRedirect) {
                            redirectPage = formRedirect;
                        }
                        
                        var redirectInput = checkoutForm.querySelector('[name="redirect-page"]');
                        if (redirectInput && redirectInput.value) {
                            redirectPage = redirectInput.value;
                        }
                    }
                    
                    console.log("Using redirect page:", redirectPage);
                    
                    setTimeout(function() {
                        // Use direct window.location assignment for more reliable redirect
                        window.location = window.baseUrl + "admin/" + redirectPage + "?invoice_id=" + invoiceId;
                    }, 100);
                } else if (value === "print" && invoiceId) {
                    // Get invoice data first
                    $.get(window.baseUrl + "_inc/invoice.php", {
                        invoice_id: invoiceId,
                        action_type: "INVOICE_DETAILS"
                    })
                    .done(function(response) {
                        try {
                            if (response.error) {
                                window.toastr.error(response.error, "Error!");
                                return;
                            }

                            // Get the Angular scope
                            var posElement = document.querySelector('[ng-controller="PosController"]');
                            if (!posElement) {
                                window.toastr.error("POS controller not found", "Error!");
                                return;
                            }
                            
                            var $scope = angular.element(posElement).scope();
                            if (!$scope) {
                                window.toastr.error("POS scope not found", "Error!");
                                return;
                            }

                            // Get PrintReceiptModal service
                            var injector = angular.element(posElement).injector();
                            if (!injector) {
                                window.toastr.error("Angular injector not found", "Error!");
                                return;
                            }

                            var PrintReceiptModal = injector.get('PrintReceiptModal');
                            if (!PrintReceiptModal) {
                                window.toastr.error("PrintReceiptModal service not found", "Error!");
                                return;
                            }

                            // Default values for missing data
                            var invoiceInfo = response.invoice_info || {};
                            var invoiceItems = response.invoice_items || [];
                            
                            // Log the response data for debugging
                            console.log("Invoice response:", response);
                            
                            // Format date
                            var created = new Date(invoiceInfo.created_at || new Date());
                            var formattedDate = created.toLocaleDateString() + ' ' + created.toLocaleTimeString();

                            // Create a direct scope object to match what the original PrintReceiptModal expects
                            var directScope = {
                                invoiceId: invoiceId,
                                invoiceInfo: {
                                    invoice_id: invoiceId,
                                    created_at: formattedDate,
                                    by: invoiceInfo.created_by || 'Admin',
                                    customer_name: invoiceInfo.customer_name || 'Walk-in Customer',
                                    customer_mobile: invoiceInfo.customer_mobile || '',
                                    customer_email: '',
                                    payable_amount: parseFloat(invoiceInfo.payable_amount || 0),
                                    paid_amount: parseFloat(invoiceInfo.paid_amount || 0),
                                    due: parseFloat(invoiceInfo.due || 0),
                                    balance: parseFloat(invoiceInfo.change || 0),
                                    discount_amount: parseFloat(invoiceInfo.discount_amount || 0),
                                    order_tax: parseFloat(invoiceInfo.order_tax || 0),
                                    shipping_amount: parseFloat(invoiceInfo.shipping_amount || 0),
                                    others_charge: parseFloat(invoiceInfo.others_charge || 0),
                                    previous_due: parseFloat(invoiceInfo.previous_due || 0),
                                    prev_due_paid: 0,
                                    return_amount: 0,
                                    invoice_note: invoiceInfo.invoice_note || ''
                                },
                                invoiceItems: invoiceItems
                            };

                            // Use special patching to handle modal.js issues
                            if (window.monkeyPatchPrintReceiptModal) {
                                console.log("Using monkey-patched PrintReceiptModal");
                                window.monkeyPatchPrintReceiptModal(directScope);
                            } else {
                                // Call PrintReceiptModal directly with scope
                                try {
                                    PrintReceiptModal(directScope);
                                } catch (e) {
                                    console.error("Print error:", e);
                                    window.toastr.error("Error printing receipt: " + e.message, "Error!");
                                }
                            }
                        } catch (e) {
                            console.error("Processing error:", e);
                            window.toastr.error("Error processing invoice data: " + e.message, "Error!");
                        }
                    })
                    .fail(function(xhr) {
                        console.error("Invoice data error:", xhr);
                        window.toastr.error("Error loading invoice data", "Error!");
                    });
                }
            });
        }
        // For all other cases, use the original swal
        return originalSwal.apply(this, arguments);
    };
})(); 