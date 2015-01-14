var cbpAnimatedHeader = function() {

    var docElem = document.documentElement,
        header = document.querySelector( '.cbp-af-header' ),
        didScroll = false,
        changeHeaderOn = 300;


    function init() {
        window.addEventListener( 'scroll', function( event ) {
            if( !didScroll ) {
                didScroll = true;
                setTimeout( scrollPage, 250 );
            }
        }, false );
    }

    function scrollPage() {
        var sy = scrollY();
        if ( sy >= changeHeaderOn ) {
            classie.add( header, 'cbp-af-header-shrink' );
        }
        else {
            classie.remove( header, 'cbp-af-header-shrink' );
        }
        didScroll = false;
    }

    function scrollY() {
        return window.pageYOffset || docElem.scrollTop;
    }

    init();


};

var readyFunction = function() {

    $("#goToJobs").click(function () {
        $('html, body').animate({
            scrollTop: $("#main-container").offset().top
        }, 1000);
    });

    cbpAnimatedHeader();

    var textSlider = $("#text-slider");
    var slides = textSlider.text().split(", ");

    textSlider.hide();

    var i = 0;

    var changeSlide = function() {
        textSlider.fadeOut(500, function () {
            textSlider.text(slides[i]);
            textSlider.fadeIn(500);

            i = (i + 1) % slides.length;

            setTimeout(changeSlide, 4000);
        });
    };

    changeSlide();
};

$(document).ready(readyFunction);
$(document).on('page:load', readyFunction);