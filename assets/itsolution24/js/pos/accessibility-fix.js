/**
 * POS Accessibility Fix for modal dialogs
 * 
 * This script addresses the WCAG accessibility issue with aria-hidden
 * by using the more modern 'inert' attribute for modals
 */
(function() {
    // First, ensure we have the inert polyfill
    if (!HTMLElement.prototype.hasOwnProperty('inert')) {
        var script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/npm/wicg-inert@3.1.2/dist/inert.min.js';
        script.async = false; // Load synchronously
        document.head.appendChild(script);
    }

    // Immediately fix any existing aria-hidden attributes
    function fixExistingAriaHidden() {
        var elements = document.querySelectorAll('[aria-hidden="true"]');
        if (elements.length > 0) {
            console.log('[Accessibility] Fixing', elements.length, 'elements with aria-hidden');
        }
        elements.forEach(function(el) {
            el.removeAttribute('aria-hidden');
            el.setAttribute('inert', '');
        });
    }

    // Run when the DOM is fully loaded
    function initAccessibilityFix() {
        console.log('Initializing accessibility fixes');
        
        // Fix for any existing elements with aria-hidden
        fixExistingAriaHidden();

        // MutationObserver to detect when aria-hidden is added
        var observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.type === 'attributes' && mutation.attributeName === 'aria-hidden') {
                    var target = mutation.target;
                    if (target.getAttribute('aria-hidden') === 'true') {
                        target.removeAttribute('aria-hidden');
                        target.setAttribute('inert', '');
                    }
                }
            });
        });

        // Start observing the whole document for aria-hidden changes
        observer.observe(document, {
            attributes: true,
            attributeFilter: ['aria-hidden'],
            subtree: true
        });

        // Fix for bootstrap modals
        $(document).on('show.bs.modal', '.modal', function() {
            console.log('[Accessibility] Modal showing');
            $('.pos-content-wrapper').attr('inert', '');
            $('.pos-content-wrapper').removeAttr('aria-hidden');
            fixExistingAriaHidden();
        });

        $(document).on('hidden.bs.modal', '.modal', function() {
            console.log('[Accessibility] Modal hidden - removing inert');
            $('.pos-content-wrapper').removeAttr('inert');
            $('.pos-content-wrapper').removeAttr('aria-hidden');
            
            // Force remove inert from all elements
            $('[inert]').each(function() {
                console.log('[Accessibility] Removing inert from:', this.tagName, this.className);
                $(this).removeAttr('inert');
            });
        });
        
        // Also cleanup on hide event
        $(document).on('hide.bs.modal', '.modal', function() {
            console.log('[Accessibility] Modal hiding - preparing cleanup');
        });

        // Fix for Angular UI Bootstrap modals
        $(document).on('$viewContentLoaded', function() {
            fixExistingAriaHidden();
        });

        // Override jQuery's attr method to intercept aria-hidden settings
        var originalAttr = $.fn.attr;
        $.fn.attr = function(name, value) {
            if (name === 'aria-hidden' && value === 'true') {
                return this.each(function() {
                    this.removeAttribute('aria-hidden');
                    this.setAttribute('inert', '');
                });
            }
            return originalAttr.apply(this, arguments);
        };

        // Only check periodically if needed, and stop after a while
        var checkCount = 0;
        var maxChecks = 10; // Only check 10 times (10 seconds)
        var intervalId = setInterval(function() {
            fixExistingAriaHidden();
            checkCount++;
            if (checkCount >= maxChecks) {
                clearInterval(intervalId);
                console.log('Accessibility fix checks completed');
            }
        }, 1000);
    }

    // Run immediately and again when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAccessibilityFix);
    } else {
        initAccessibilityFix();
    }

    // Also run when all resources are loaded
    window.addEventListener('load', fixExistingAriaHidden);
})(); 