window.angularApp.factory("PaymentFormModal", ["API_URL", "window", "jQuery", "$http", "$uibModal", "$sce", "InvoiceViewModal", "PrintReceiptModal", "$rootScope", function (API_URL, window, $, $http, $uibModal, $sce, InvoiceViewModal, PrintReceiptModal, $scope) {
    return function($scope) {
        // Store focused element before opening modal
        var previouslyFocused = document.activeElement;
        
        var uibModalInstance = $uibModal.open({
            animation: true,
            ariaLabelledBy: "modal-title",
            ariaDescribedBy: "modal-body",
            template: "<div class=\"modal-header\">" +
                            "<button ng-click=\"closePaymentFormModal();\" type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" +
                            "<h3 class=\"modal-title\" id=\"modal-title\">" + 
                                "<span class=\"fa fa-fw fa-list\"></span> {{ modal_title }}" +
                            "</h3>" +
                        "</div>" +
                        "<div class=\"modal-body\" id=\"modal-body\" style=\"padding: 0px;overflow-x: hidden;\">" +
                            "<div bind-html-compile=\"rawHtml\">Loading...</div>" +
                        "</div>" +
                        "<div class=\"modal-footer\">" +
                            "<button ng-click=\"closePaymentFormModal();\" type=\"button\" class=\"btn btn-danger radius-50\" tabindex=\"1\"><i class=\"fa fa-fw fa-close\"></i> Close</button>" +
                            "<button ng-click=\"goToInvoice();\" type=\"button\" class=\"btn btn-info radius-50\" tabindex=\"2\"><i class=\"fa fa-fw fa-file-text\"></i> Go to Invoice</button>" +
                            "<button ng-click=\"checkoutWithFullPaidAndPrint();\" type=\"button\" class=\"btn btn-primary radius-50\" tabindex=\"3\"><i class=\"fa fa-fw fa-money\"></i> <i class=\"fa fa-fw fa-print\"></i> Full Payment & View</button>" +
                            "<button ng-click=\"checkout();\" type=\"button\" class=\"btn btn-success radius-50\" tabindex=\"4\"><i class=\"fa fa-fw fa-money\"></i> Checkout &rarr;</button>" +
                        "</div>",
            controller: function ($scope, $uibModalInstance) {
                $(document).find("body").addClass("overlay-loader");
                
                // Use inert attribute instead of aria-hidden
                $('.pos-content-wrapper').attr('inert', '');
                $('.pos-content-wrapper').removeAttr('aria-hidden');
                
                $http({
                  url: window.baseUrl+"_inc/template/payment_form.php?customer_id="+$scope.customerId,
                  method: "GET"
                })
                .then(function(response, status, headers, config) {
                    $scope.modal_title = "Payment > " + $scope.customerName;
                    $scope.rawHtml = $sce.trustAsHtml(response.data);
                    setTimeout(function() {
                        storeApp.bootBooxHeightAdjustment();
                        $(document).find("body").removeClass("overlay-loader");
                        
                        // Focus management
                        var firstInput = document.querySelector('.modal-body input:not([type="hidden"]), .modal-body button:not(.close)');
                        if (firstInput) {
                            firstInput.focus();
                        }
                    }, 500);                 
                }, function(response) {
                   window.swal("Oops!", response.data.errorMsg, "error");
                   $(document).find("body").removeClass("overlay-loader");
                });

                $scope.sellWithInstallment = function() {
                    if ($scope.isInstallmentOrder == 0) {
                        $scope.isInstallmentOrder = 1;
                        $("#activeSellWithInstallmentBtn").removeClass("btn-default");
                        $("#activeSellWithInstallmentBtn").addClass("btn-success");
                    } else {
                        $scope.isInstallmentOrder = 0;
                        $("#activeSellWithInstallmentBtn").removeClass("btn-success");
                        $("#activeSellWithInstallmentBtn").addClass("btn-default");
                    }
                }

                $scope.selectPaymentMethod = function(pmethodId,pmethodCode) {
                    $(document).find("body").addClass("overlay-loader");
                    $scope.pmethodId = pmethodId;
                    $scope.pmethodCode = pmethodCode;
                    $(".pmethod_item").removeClass("active");
                    $("#pmethod_"+pmethodId).addClass("active");

                    $http({
                      url: window.baseUrl+"_inc/payment.php?action_type=FIELD&pmethod_id=" + pmethodId,
                      method: "GET"
                    })
                    .then(function(response, status, headers, config) {
                        $scope.modal_title = "Payment > " + $scope.customerName;
                        $scope.rawPaymentMethodHtml = $sce.trustAsHtml(response.data);
                        if ($scope.pmethodCode == 'credit') {
                            if (parseFloat($scope.customerBalance) < parseFloat($scope.totalPayable)) {
                                window.toastr.error("Insufficient Balance!", "Warning!");
                            } else {
                                $scope.paidAmount = $scope.totalPayable;
                            }
                        }
                        $(document).find("body").removeClass("overlay-loader");
                    }, function(response) {
                       window.swal("Oops!", response.data.errorMsg, "error");
                       $(document).find("body").removeClass("overlay-loader");
                    });
                };

                $scope.checkout = function() {
                    // Ensure inert attribute is used properly
                    $('.pos-content-wrapper').attr('inert', '');
                    $('.pos-content-wrapper').removeAttr('aria-hidden');
                    
                    $(document).find(".modal").addClass("overlay-loader");
                    var form = $("#checkout-form");
                    var actionUrl = form.attr("action");
                    var data = form.serialize();
                    $http({
                        url: window.baseUrl+"_inc/" + actionUrl,
                        method: "POST",
                        data: data,
                        cache: false,
                        processData: false,
                        contentType: false,
                        dataType: "json"
                    }).
                    then(function(response) {
                        window.onbeforeunload = null;
                        $(document).find(".modal").removeClass("overlay-loader");
                        $scope.invoiceId = response.data.invoice_id;
                        $scope.invoiceInfo = response.data.invoice_info;
                        $scope.invoiceItems = response.data.invoice_items;
                        $scope.done = true;
                        
                        // Close payment modal first
                        $scope.resetPos();
                        $scope.closePaymentFormModal();
                        
                        if (window.store.sound_effect == 1) {
                            window.storeApp.playSound("modify.mp3");
                        }
                        
                        // Print automatically if auto_print is enabled
                        if (window.store.auto_print == 1) {
                            PrintReceiptModal($scope);
                        }

                        // Show success message with print button or redirect
                        if ($scope.shouldRedirectAfterCheckout === true) {
                            // Reset the flag
                            $scope.shouldRedirectAfterCheckout = false;
                            
                            // Add a small delay to ensure everything is processed
                            setTimeout(function() {
                                // Redirect to invoice view page
                                window.location.href = window.baseUrl + "admin/view_invoice.php?invoice_id=" + $scope.invoiceId;
                            }, 300);
                        } else {
                        setTimeout(function() {
                            // Hide any existing success messages
                            $(".alert-success").hide();
                            
                            // Show success message with invoice ID
                            window.swal("Success", "ID: " + $scope.invoiceId, "success");
                        }, 100);
                        }
                        
                        if ($scope.customerMobileNumber && window.settings.invoice_auto_sms == '1') {
                            $http({
                                url: window.baseUrl+"_inc/sms/index.php",
                                method: "POST",
                                data: "phone_number="+$scope.customerMobileNumber+"&invoice_id="+$scope.invoiceId+"&action_type=SEND",
                                cache: false,
                                processData: false,
                                contentType: false,
                                dataType: "json"
                            }).
                            then(function(response) {
                                window.toastr.success("SMS sent to the number: " + $scope.customerMobileNumber, "Success!");
                            }, function(response) {
                                window.swal("Oops!", response.data.errorMsg, "error");
                            });
                        }
                    }, function(response) {
                        if (window.store.sound_effect == 1) {
                            window.storeApp.playSound("error.mp3");
                        }
                        window.swal("Oops!", response.data.errorMsg, "error");
                        $(document).find(".modal").removeClass("overlay-loader");
                    });
                };

                $scope.checkoutWithFullPaid = function() {
					$scope.paidAmount = $scope.totalPayable;
	                window.swal({
					  title: "Full Payment!",
					  text: "Are  sure that u want to make full payment?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: false,
					})
					.then(function(willDelete) {
					    if (willDelete) {
		                    setTimeout(function() {
		                        $scope.checkout();
		                    }, 200);
					    }
					});
				};
                
                // New function for full payment and print payment with redirect
                $scope.checkoutWithFullPaidAndPrint = function() {
					$scope.paidAmount = $scope.totalPayable;
	                window.swal({
					  title: "Full Payment!",
					  text: "Are  sure that u want to make full payment and print?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: false,
					})
					.then(function(willDelete) {
					    if (willDelete) {
		                    setTimeout(function() {
                                // Set flag to redirect after checkout
                                $scope.shouldRedirectAfterCheckout = true;
                                
                                // Force print receipt even if auto_print is disabled
                                var originalAutoPrint = window.store.auto_print;
                                window.store.auto_print = 1;
                                
                                // Process checkout
                                $scope.checkout();
                                
                                // Restore original auto_print setting
                                setTimeout(function() {
                                    window.store.auto_print = originalAutoPrint;
                                }, 100);
		                    }, 200);
					    }
					});
				};  

                $scope.goToInvoice = function() {
                    // Process payment first
                    $scope.paidAmount = $scope.totalPayable;
                    
                    window.swal({
                      title: "Go to Invoice",
                      text: "Process payment and go to invoice?",
                      icon: "info",
                      buttons: true,
                    })
                    .then(function(willProceed) {
                        if (willProceed) {
                            $(document).find(".modal").addClass("overlay-loader");
                            var form = $("#checkout-form");
                            var actionUrl = form.attr("action");
                            var data = form.serialize();
                            
                            $http({
                                url: window.baseUrl+"_inc/" + actionUrl,
                                method: "POST",
                                data: data,
                                cache: false,
                                processData: false,
                                contentType: false,
                                dataType: "json"
                            }).
                            then(function(response) {
                                $(document).find(".modal").removeClass("overlay-loader");
                                var invoiceId = response.data.invoice_id;
                                
                                // Close modal
                                $scope.resetPos();
                                $scope.closePaymentFormModal();
                                
                                // Redirect to invoice view page
                                window.location.href = window.baseUrl + "admin/view_invoice.php?invoice_id=" + invoiceId;
                            }, function(response) {
                                $(document).find(".modal").removeClass("overlay-loader");
                                window.swal("Error", response.data.errorMsg, "error");
                            });
                        }
                    });
                };
                
                $scope.checkoutWithFullDue = function() {
                    $scope.paidAmount = 0;
                    setTimeout(function() {
                        $scope.checkout();
                    }, 100);
                };

                $scope.checkoutWhilePressEnter = function($event) {
                    if(($event.keyCode || $event.which) == 13){
                        $scope.checkout();
                    }
                };

                $scope.closePaymentFormModal = function () {
                    // Remove inert attribute when closing modal
                    $('.pos-content-wrapper').removeAttr('inert');
                    $('.pos-content-wrapper').removeAttr('aria-hidden');
                    
                    // Restore focus to previously focused element
                    if (previouslyFocused && previouslyFocused.focus) {
                        setTimeout(function() {
                            previouslyFocused.focus();
                        }, 0);
                    }
                    
                    $uibModalInstance.dismiss("cancel");
                };

                // Handle modal open
                $scope.$on('modal.opened', function() {
                    // Use inert attribute instead of aria-hidden
                    $('.pos-content-wrapper').attr('inert', '');
                    $('.pos-content-wrapper').removeAttr('aria-hidden');
                });

                // Handle modal closing
                $scope.$on('modal.closing', function() {
                    // Remove inert attribute when closing modal
                    $('.pos-content-wrapper').removeAttr('inert');
                    $('.pos-content-wrapper').removeAttr('aria-hidden');
                });

                $scope.$watch('installmentInterestPercentage', function() {
                    $scope.installmentInterestAmount = ($scope.installmentInterestPercentage/100)*$scope.payable;
                    $scope._calcTotalPayable($scope);
                }, true);
            },
            scope: $scope,
            size: "lg",
            backdrop: "static",
            keyboard: true,
        });

        uibModalInstance.result.catch(function () { 
            // Remove inert attribute and restore focus
            $('.pos-content-wrapper').removeAttr('inert');
            $('.pos-content-wrapper').removeAttr('aria-hidden');
            if (previouslyFocused && previouslyFocused.focus) {
                setTimeout(function() {
                    previouslyFocused.focus();
                }, 0);
            }
            uibModalInstance.close(); 
        });
    };
}]);