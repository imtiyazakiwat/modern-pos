/**
 * Payment Modal Fix for Windows
 * 
 * This script ensures the payment modal opens properly on Windows systems
 * and prevents page freezing when clicking the Pay button
 */
(function () {
    'use strict';

    console.log('[Payment Modal Fix] Initializing payment modal fix for Windows compatibility');

    var isProcessingPayment = false;
    var paymentModalOpenAttempts = 0;
    var maxAttempts = 3;

    /**
     * Force cleanup of any blocking elements before opening payment modal
     */
    function cleanupBeforePayment() {
        console.log('[Payment Modal Fix] Cleaning up before payment modal');

        // Remove any stuck overlays
        $('body').removeClass('overlay-loader');
        $('.modal').removeClass('overlay-loader');

        // Remove stuck backdrops
        $('.modal-backdrop').remove();

        // Remove inert attributes
        $('.pos-content-wrapper').removeAttr('inert');
        $('.pos-content-wrapper').removeAttr('aria-hidden');

        // Ensure body is interactive
        $('body').css({
            'overflow': '',
            'padding-right': '',
            'pointer-events': ''
        });

        // Close any existing modals
        $('.modal').modal('hide');

        console.log('[Payment Modal Fix] Cleanup completed');
    }

    /**
     * Enhanced pay button click handler
     */
    function handlePayButtonClick(e) {
        console.log('[Payment Modal Fix] Pay button clicked');

        // Prevent multiple simultaneous payment processing
        if (isProcessingPayment) {
            console.log('[Payment Modal Fix] Payment already processing, ignoring click');
            e.preventDefault();
            e.stopPropagation();
            e.stopImmediatePropagation();
            return false;
        }

        isProcessingPayment = true;
        paymentModalOpenAttempts++;

        console.log('[Payment Modal Fix] Processing payment, attempt #' + paymentModalOpenAttempts);

        // Clean up any blocking elements
        cleanupBeforePayment();

        // Reset the processing flag after modal should have opened
        setTimeout(function () {
            isProcessingPayment = false;
            console.log('[Payment Modal Fix] Reset processing flag');
        }, 2000);

        // Let Angular handle the click - don't interfere
        return true;
    }

    /**
     * Monitor for payment modal opening
     */
    function monitorPaymentModal() {
        var checkCount = 0;
        var maxChecks = 50; // 5 seconds

        var checkInterval = setInterval(function () {
            checkCount++;

            // Check if modal is opening
            var modalOpening = $('.modal.in, .modal.show, .payment-modal-window').length > 0;

            if (modalOpening) {
                console.log('[Payment Modal Fix] Payment modal detected as opening');
                clearInterval(checkInterval);

                // Prevent any cleanup for the next 2 seconds
                window.paymentModalProtected = true;
                setTimeout(function () {
                    window.paymentModalProtected = false;
                    console.log('[Payment Modal Fix] Modal protection period ended');
                }, 2000);

                // Ensure modal is fully interactive
                setTimeout(function () {
                    $('.modal').removeClass('overlay-loader');
                    $('body').removeClass('overlay-loader');

                    // Prevent backdrop from closing modal
                    $('.modal-backdrop').off('click');

                    // Focus first input in modal
                    var firstInput = $('.modal input:visible:not([type="hidden"]):first');
                    if (firstInput.length > 0) {
                        firstInput.focus();
                        console.log('[Payment Modal Fix] Focused first input in modal');
                    }
                }, 500);
            }

            if (checkCount >= maxChecks) {
                console.log('[Payment Modal Fix] Modal monitoring timeout');
                clearInterval(checkInterval);
                isProcessingPayment = false;
            }
        }, 100);
    }

    /**
     * Initialize the fix
     */
    function init() {
        // Wait for DOM to be ready
        $(document).ready(function () {
            console.log('[Payment Modal Fix] DOM ready, attaching handlers');

            // Pre-cleanup before any pay button interaction
            $(document).on('mousedown', '#pay-button button:first, button[ng-click*="payNow"]', function (e) {
                console.log('[Payment Modal Fix] Pay button mousedown - pre-cleanup');
                cleanupBeforePayment();
            });

            // Monitor for modal opening after click
            $(document).on('click', '#pay-button button:first, button[ng-click*="payNow"]', function (e) {
                console.log('[Payment Modal Fix] Pay button click intercepted');
                handlePayButtonClick(e);
                monitorPaymentModal();
            });

            // Also handle Enter key in payment fields
            $(document).on('keypress', '#invoice-item input, #invoice-calculation input', function (e) {
                if (e.which === 13 && e.target.id !== 'product-name' && e.target.id !== 'customer-name') {
                    console.log('[Payment Modal Fix] Enter key pressed in invoice field');
                    // Don't trigger payment on Enter in these fields
                }
            });

            // Monitor for stuck states every 2 seconds
            setInterval(function () {
                // Only check if no modal is open
                if ($('.modal.in, .modal.show').length === 0) {
                    var hasOverlay = $('body').hasClass('overlay-loader') || $('.modal').hasClass('overlay-loader');
                    var hasBackdrop = $('.modal-backdrop').length > 0;
                    var hasInert = $('.pos-content-wrapper[inert]').length > 0;

                    if (hasOverlay || hasBackdrop || hasInert) {
                        console.log('[Payment Modal Fix] Detected stuck state - overlay:', hasOverlay, 'backdrop:', hasBackdrop, 'inert:', hasInert);
                        cleanupBeforePayment();
                    }
                }
            }, 2000);

            // Handle modal shown event
            $(document).on('shown.bs.modal', '.modal', function () {
                console.log('[Payment Modal Fix] Modal shown event');
                isProcessingPayment = false;

                // Ensure modal content is interactive
                $(this).removeClass('overlay-loader');
                $('body').removeClass('overlay-loader');
            });

            // Handle modal hidden event
            $(document).on('hidden.bs.modal', '.modal', function () {
                console.log('[Payment Modal Fix] Modal hidden event');
                isProcessingPayment = false;
                cleanupBeforePayment();
            });

            console.log('[Payment Modal Fix] Initialization complete');
        });
    }

    // Initialize immediately
    init();

    // Expose cleanup function globally for emergency use
    window.forcePaymentCleanup = cleanupBeforePayment;

    console.log('[Payment Modal Fix] Payment modal fix loaded');
})();
