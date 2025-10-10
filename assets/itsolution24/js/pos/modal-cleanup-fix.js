/**
 * Modal Cleanup Fix
 * 
 * This script ensures that overlay-loader classes and other modal artifacts
 * are properly cleaned up when modals are closed to prevent page freezing
 */
(function() {
    console.log('[Modal Cleanup] Initializing modal cleanup fix');
    
    var cleanupCount = 0;
    
    // Function to force cleanup of modal artifacts
    function forceCleanup() {
        // Don't cleanup if payment modal is protected
        if (window.paymentModalProtected) {
            console.log('[Modal Cleanup] Payment modal is protected, skipping cleanup');
            return;
        }
        
        // Don't cleanup if payment modal is confirmed open
        if ($('.payment-modal-window.modal-open-confirmed').length > 0) {
            console.log('[Modal Cleanup] Payment modal is open, skipping cleanup');
            return;
        }
        
        cleanupCount++;
        console.log('[Modal Cleanup] Running cleanup #' + cleanupCount);
        
        // Remove overlay-loader from body and modals
        var bodyHasOverlay = $('body').hasClass('overlay-loader');
        var modalHasOverlay = $('.modal').hasClass('overlay-loader');
        
        if (bodyHasOverlay) {
            console.log('[Modal Cleanup] Removing overlay-loader from body');
            $('body').removeClass('overlay-loader');
        }
        
        if (modalHasOverlay) {
            console.log('[Modal Cleanup] Removing overlay-loader from modal');
            $('.modal').removeClass('overlay-loader');
        }
        
        // Check for stuck modal backdrops
        var backdrops = $('.modal-backdrop');
        if (backdrops.length > 0) {
            console.log('[Modal Cleanup] Found', backdrops.length, 'modal backdrops');
            // Only remove if no modals are actually open
            if ($('.modal.in, .modal.show, .payment-modal-window').length === 0) {
                console.log('[Modal Cleanup] No open modals, removing backdrops');
                backdrops.remove();
                $('body').removeClass('modal-open');
            }
        }
        
        // Re-enable body scrolling if needed
        if ($('.modal.in, .modal.show').length === 0) {
            console.log('[Modal Cleanup] Re-enabling body interaction');
            $('body').css('overflow', '');
            $('body').css('padding-right', '');
            $('body').removeClass('modal-open');
        }
        
        // Remove any inert attributes that might be blocking interaction
        var inertElements = $('[inert]');
        if (inertElements.length > 0 && $('.modal.in, .modal.show').length === 0) {
            console.log('[Modal Cleanup] Removing inert from', inertElements.length, 'elements');
            inertElements.removeAttr('inert');
        }
        
        // Check for any elements with pointer-events: none
        var posWrapper = $('.pos-content-wrapper');
        if (posWrapper.length > 0) {
            var pointerEvents = posWrapper.css('pointer-events');
            if (pointerEvents === 'none') {
                console.log('[Modal Cleanup] Re-enabling pointer events on POS wrapper');
                posWrapper.css('pointer-events', '');
            }
        }
        
        // Force remove any lingering modal classes
        $('.modal').removeClass('in show');
        
        console.log('[Modal Cleanup] Cleanup #' + cleanupCount + ' completed');
    }
    
    // Run cleanup when modal is hidden
    $(document).on('hidden.bs.modal', '.modal', function() {
        console.log('[Modal Cleanup] Modal hidden event triggered');
        // Don't cleanup if payment modal is still open
        if ($('.payment-modal-window.modal-open-confirmed').length > 0) {
            console.log('[Modal Cleanup] Payment modal is open, skipping cleanup');
            return;
        }
        forceCleanup();
        // Run again after a delay to catch any stragglers
        setTimeout(forceCleanup, 100);
        setTimeout(forceCleanup, 500);
    });
    
    // Also run on hide event (before hidden)
    $(document).on('hide.bs.modal', '.modal', function() {
        console.log('[Modal Cleanup] Modal hide event triggered');
        // Don't cleanup if payment modal is confirmed open
        if ($('.payment-modal-window.modal-open-confirmed').length > 0) {
            console.log('[Modal Cleanup] Payment modal is open, skipping pre-cleanup');
            return;
        }
        // Start cleanup immediately
        setTimeout(forceCleanup, 50);
    });
    
    // Safety cleanup - run periodically for first 10 seconds
    var safetyCheckCount = 0;
    var maxSafetyChecks = 10;
    var safetyInterval = setInterval(function() {
        safetyCheckCount++;
        
        // Check if there are any stuck overlays
        if ($('body').hasClass('overlay-loader') || $('.modal').hasClass('overlay-loader')) {
            console.log('[Modal Cleanup] Safety check found stuck overlay at check #' + safetyCheckCount);
            forceCleanup();
        }
        
        if (safetyCheckCount >= maxSafetyChecks) {
            console.log('[Modal Cleanup] Safety checks completed');
            clearInterval(safetyInterval);
        }
    }, 1000);
    
    // Emergency cleanup on any click outside modal
    $(document).on('click', '.modal-backdrop', function() {
        console.log('[Modal Cleanup] Backdrop clicked, scheduling cleanup');
        setTimeout(forceCleanup, 500);
    });
    
    // Cleanup on ESC key (but not for payment modal)
    $(document).on('keydown', function(e) {
        if (e.keyCode === 27) { // ESC key
            // Don't cleanup if payment modal is open
            if ($('.payment-modal-window.modal-open-confirmed').length > 0) {
                console.log('[Modal Cleanup] ESC pressed but payment modal is open, ignoring');
                return;
            }
            console.log('[Modal Cleanup] ESC key pressed, scheduling cleanup');
            setTimeout(forceCleanup, 500);
        }
    });
    
    // Add a test click handler to verify clicks are working
    $(document).on('click', '.pos-content-wrapper', function(e) {
        console.log('[Modal Cleanup] Click detected on POS wrapper at:', e.target.tagName, e.target.className);
    });
    
    // Monitor for any elements blocking clicks
    setInterval(function() {
        // Don't monitor if payment modal is protected or open
        if (window.paymentModalProtected || $('.payment-modal-window.modal-open-confirmed').length > 0) {
            return;
        }
        
        if ($('.modal.in, .modal.show, .payment-modal-window').length === 0) {
            // No modals open, check for blocking elements
            var inertCount = $('[inert]').length;
            var overlayCount = $('.overlay-loader').length;
            var backdropCount = $('.modal-backdrop').length;
            
            if (inertCount > 0 || overlayCount > 0 || backdropCount > 0) {
                console.log('[Modal Cleanup] WARNING: Blocking elements detected - inert:', inertCount, 'overlay:', overlayCount, 'backdrop:', backdropCount);
                forceCleanup();
            }
        }
    }, 2000);
    
    console.log('[Modal Cleanup] Modal cleanup fix initialized');
})();
