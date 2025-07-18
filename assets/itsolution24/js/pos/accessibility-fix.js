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
            $('.pos-content-wrapper').attr('inert', '');
            $('.pos-content-wrapper').removeAttr('aria-hidden');
            fixExistingAriaHidden();
        });

        $(document).on('hidden.bs.modal', '.modal', function() {
            $('.pos-content-wrapper').removeAttr('inert');
            $('.pos-content-wrapper').removeAttr('aria-hidden');
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

        // Make sure all modals use inert instead of aria-hidden
        setInterval(fixExistingAriaHidden, 1000);
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