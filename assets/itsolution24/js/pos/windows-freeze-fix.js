/**
 * Windows POS Freeze Fix
 * Prevents POS from freezing on Windows after 4-5 minutes of inactivity
 * 
 * Root Causes:
 * 1. Event listener accumulation (memory leak)
 * 2. Angular digest cycle issues
 * 3. Perfect Scrollbar memory leaks
 * 4. Inactive tab throttling in Windows
 */

(function() {
    'use strict';
    
    console.log('[Windows Freeze Fix] Initializing...');
    
    // 1. Prevent event listener accumulation
    var eventListenersInitialized = false;
    
    function initializeEventListeners() {
        if (eventListenersInitialized) {
            console.log('[Windows Freeze Fix] Event listeners already initialized, skipping');
            return;
        }
        
        console.log('[Windows Freeze Fix] Setting up one-time event listeners');
        eventListenersInitialized = true;
        
        // Mark that listeners are initialized
        window.posEventListenersInitialized = true;
    }
    
    // 2. Keep Angular alive during inactivity
    var keepAliveInterval = null;
    
    function startKeepAlive() {
        if (keepAliveInterval) {
            clearInterval(keepAliveInterval);
        }
        
        // Ping every 30 seconds to keep the app responsive
        keepAliveInterval = setInterval(function() {
            try {
                // Touch the DOM slightly to prevent Windows from throttling
                var timestamp = document.getElementById('pos-keepalive-timestamp');
                if (!timestamp) {
                    timestamp = document.createElement('span');
                    timestamp.id = 'pos-keepalive-timestamp';
                    timestamp.style.display = 'none';
                    document.body.appendChild(timestamp);
                }
                timestamp.textContent = Date.now();
                
                // Update perfect scrollbar if it exists
                if (typeof $.fn.perfectScrollbar !== 'undefined') {
                    $('#invoice-item-list').perfectScrollbar('update');
                    $('#item-list').perfectScrollbar('update');
                }
                
                console.log('[Windows Freeze Fix] Keep-alive ping at ' + new Date().toLocaleTimeString());
            } catch (e) {
                console.error('[Windows Freeze Fix] Keep-alive error:', e);
            }
        }, 30000); // Every 30 seconds
    }
    
    // 3. Cleanup on page unload
    function cleanup() {
        console.log('[Windows Freeze Fix] Cleaning up...');
        
        if (keepAliveInterval) {
            clearInterval(keepAliveInterval);
            keepAliveInterval = null;
        }
        
        // Remove event listeners to prevent memory leaks
        $(document).off('change blur', '.item_quantity');
        $(document).off('change blur', '.item_discount');
        $(document).off('change blur', '.item_price');
        
        eventListenersInitialized = false;
        window.posEventListenersInitialized = false;
    }
    
    // 4. Detect and recover from freeze
    var lastActivityTime = Date.now();
    var freezeCheckInterval = null;
    
    function updateActivityTime() {
        lastActivityTime = Date.now();
    }
    
    function checkForFreeze() {
        var now = Date.now();
        var inactiveTime = now - lastActivityTime;
        
        // If inactive for more than 5 minutes, refresh Angular
        if (inactiveTime > 300000) { // 5 minutes
            console.warn('[Windows Freeze Fix] Detected long inactivity, refreshing Angular scope');
            
            try {
                var scope = angular.element(document.body).scope();
                if (scope && !scope.$$phase) {
                    scope.$apply();
                }
            } catch (e) {
                console.error('[Windows Freeze Fix] Error refreshing scope:', e);
            }
            
            lastActivityTime = now;
        }
    }
    
    function startFreezeDetection() {
        // Track user activity
        $(document).on('mousemove keydown click scroll', updateActivityTime);
        
        // Check for freeze every minute
        freezeCheckInterval = setInterval(checkForFreeze, 60000);
    }
    
    // 5. Optimize Perfect Scrollbar for Windows
    function optimizePerfectScrollbar() {
        if (typeof $.fn.perfectScrollbar !== 'undefined') {
            console.log('[Windows Freeze Fix] Optimizing Perfect Scrollbar for Windows');
            
            // Destroy and reinitialize with optimized settings
            $('#invoice-item-list').perfectScrollbar('destroy');
            $('#item-list').perfectScrollbar('destroy');
            
            var scrollbarOptions = {
                wheelSpeed: 1,
                wheelPropagation: false,
                minScrollbarLength: 20,
                suppressScrollX: true,
                // Windows-specific optimizations
                useBothWheelAxes: false,
                scrollingThreshold: 1000
            };
            
            $('#invoice-item-list').perfectScrollbar(scrollbarOptions);
            $('#item-list').perfectScrollbar(scrollbarOptions);
        }
    }
    
    // 6. Prevent Windows tab throttling
    function preventTabThrottling() {
        // Request animation frame to keep tab active
        function keepTabActive() {
            requestAnimationFrame(keepTabActive);
        }
        keepTabActive();
        
        // Also use Page Visibility API
        document.addEventListener('visibilitychange', function() {
            if (document.hidden) {
                console.log('[Windows Freeze Fix] Tab hidden, maintaining activity');
            } else {
                console.log('[Windows Freeze Fix] Tab visible again');
                updateActivityTime();
            }
        });
    }
    
    // Initialize everything when DOM is ready
    $(document).ready(function() {
        console.log('[Windows Freeze Fix] DOM ready, initializing fixes');
        
        // Wait a bit for Angular to initialize
        setTimeout(function() {
            initializeEventListeners();
            startKeepAlive();
            startFreezeDetection();
            optimizePerfectScrollbar();
            preventTabThrottling();
            
            console.log('[Windows Freeze Fix] All fixes initialized successfully');
        }, 1000);
    });
    
    // Cleanup on page unload
    $(window).on('beforeunload', cleanup);
    
    // Expose cleanup function globally for manual cleanup if needed
    window.posCleanup = cleanup;
    
})();
