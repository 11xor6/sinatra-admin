// Navigation Menu Tree
jQuery(document).ready(function($) {
    $('#nav-menu').dcAccordion({
                showCount: true,
                speed: 'slow',
                autoClose: 'false'
    });

    // Open in new window/local
    jQuery('a.link').click(function(e){
        if(e.button === 0 && !(e.ctrlKey || e.metaKey)){ // Left Click without ctrl
            e.preventDefault();
            // open local page
            window.location = $(this).data('link');
        }
        // Middle click and ctrl click will do nothing,
        // thus allowing the brower to open in a new window
    });

});
