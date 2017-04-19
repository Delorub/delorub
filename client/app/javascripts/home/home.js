import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import $ from 'jquery';
import 'imports-loader?jQuery=jquery!owl.carousel';
import "bootstrap-slider/dist/bootstrap-slider.js";
import "bootstrap-slider/dist/css/bootstrap-slider.css";
import "select2/dist/js/select2.js";
import "select2/dist/css/select2.css";

$(document).ready(function () {
    $('.owl-carousel').owlCarousel({
        loop: true,
        animateOut: 'fadeOut',
        touchDrag: false,
        mouseDrag: true,
        loop: true,
        dots: true,
        margin: 0,
        nav: true,
        navText: [""],
        autoplay: false,
        smartSpeed: 450,
        autoplayTimeout: 1000,
        autoplayHoverPause: true,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 1
            },
            1000: {
                items: 1
            }
        }
    });
});

$('#ex1').slider({
    formatter: function (value) {
        return 'Current value: ' + value;
    }
});

$("select").select2({
  tags: true
})
