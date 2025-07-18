/**
 * Customer Mobile Field Fix
 * 
 * This script patches various issues with customer_mobile field
 * being undefined in various parts of the application.
 */
(function() {
    // Wait for DOM and Angular to be ready
    function initFix() {
        if (!window.angular) {
            setTimeout(initFix, 500);
            return;
        }
        
        console.log('Initializing customer mobile field fixes');
        
        // Monkey patch the modal.js issue with customer_mobile
        try {
            // Find any element with ng-controller
            var elements = document.querySelectorAll('[ng-controller]');
            for (var i = 0; i < elements.length; i++) {
                var element = angular.element(elements[i]);
                if (element.injector) {
                    var injector = element.injector();
                    if (injector) {
                        // Patch the $rootScope to ensure customer data is always valid
                        var $rootScope = injector.get('$rootScope');
                        if ($rootScope) {
                            // Watch for invoice info changes
                            $rootScope.$watch(function() {
                                // Find and fix any customer mobile issues
                                Object.keys($rootScope).forEach(function(key) {
                                    if (typeof $rootScope[key] === 'object' && $rootScope[key] !== null) {
                                        // Fix invoiceInfo objects
                                        if ($rootScope[key].invoiceInfo) {
                                            if ($rootScope[key].invoiceInfo.customer_mobile === undefined) {
                                                $rootScope[key].invoiceInfo.customer_mobile = '';
                                            }
                                        }
                                        
                                        // Fix customer objects
                                        if ($rootScope[key].customer) {
                                            if ($rootScope[key].customer.mobile === undefined) {
                                                $rootScope[key].customer.mobile = '';
                                            }
                                            if ($rootScope[key].customer.customer_mobile === undefined) {
                                                $rootScope[key].customer.customer_mobile = '';
                                            }
                                        }
                                    }
                                });
                            });
                            
                            console.log('Customer mobile field fix applied');
                        }
                        break;
                    }
                }
            }
        } catch (e) {
            console.error('Error applying customer mobile fix:', e);
        }
    }
    
    // Start the fix
    setTimeout(initFix, 1000);
})(); 