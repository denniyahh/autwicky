/*
 * Click-to-expand Mermaid diagrams to full viewport.
 * Targets the panzoom wrapper which receives user clicks.
 * Toggle via click; close via click or Escape.
 */
document.addEventListener('DOMContentLoaded', function () {
    function attachExpand(container) {
        // The panzoom wrapper (.panzoom-box) is the clickable container
        const wrapper = container.closest('.panzoom-box') || container;
        wrapper.style.cursor = 'zoom-in';

        wrapper.addEventListener('click', function (e) {
            // Don't intercept panzoom button clicks
            if (e.target.closest('.panzoom-button, .panzoom-controls button')) return;
            container.classList.toggle('expanded');
            wrapper.style.cursor = container.classList.contains('expanded') ? 'zoom-out' : 'zoom-in';
        });
    }

    // Attach to all mermaid diagrams, retry for async loading
    function init() {
        document.querySelectorAll('.md-typeset .mermaid').forEach(function (el) {
            if (!el.dataset.expandAttached) {
                el.dataset.expandAttached = '1';
                attachExpand(el);
            }
        });
    }

    init();
    // Retry after mermaid renders (mermaid2 loads async)
    setTimeout(init, 1000);
    setTimeout(init, 3000);

    // Esc key closes any expanded diagram
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            document.querySelectorAll('.md-typeset .mermaid.expanded').forEach(function (el) {
                el.classList.remove('expanded');
                const wrapper = el.closest('.panzoom-box');
                if (wrapper) wrapper.style.cursor = 'zoom-in';
            });
        }
    });
});
