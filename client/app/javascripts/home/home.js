import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import $ from 'jquery';
import 'imports-loader?jQuery=jquery!owl.carousel';
import "bootstrap-slider/dist/bootstrap-slider.js";
import "bootstrap-slider/dist/css/bootstrap-slider.css";
import "select2/dist/js/select2.js";
import "select2/dist/css/select2.css";


$("#alert").click(function () {
    alert("Handler for .click() called.");
});

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
$('#ex2').slider({
    formatter: function (value) {
        return 'Current value: ' + value;
    }
});
$(".select2").select2({
    tags: true
});
$(document).ready(function () {
    $("a.dr-dropdown-button").click(function () {
        $("span.dr-dropdown-arrow-bottom").toggleClass("dr-dropdown-arrow-top");
        return false;
    });
});
jQuery(function ($) {
    $('#open-notification-link').click(function (e) {
        $('#open-notification').show();
    });
    $(document).mouseup(function (e) { // событие клика по веб-документу
        var div = $("#open-notification"); // тут указываем ID элемента
        if (!div.is(e.target) // если клик был не по нашему блоку
                && div.has(e.target).length === 0 // и не по его дочерним элементам
                && div.css('display') !== 'none') { // и блок не скрыт
            div.hide(); // скрываем его
        }
    });
});
jQuery(function ($) {
    $('#open-search-link').click(function (e) {
        $("div.sb-search").addClass("sb-search-open");
        $("#toggle-nav").addClass("nav-close");
    });
    $(document).mouseup(function (e) {
        var div = $("div.sb-search"); // тут указываем ID элемента
        if (!div.is(e.target) // если клик был не по нашему блоку
                && div.has(e.target).length === 0 // и не по его дочерним элементам
                && !$('#open-search-link').is(e.target)
                && $("ul.nav-close").css('display') === 'none'
                )
        {
            div.removeClass("sb-search-open");
            setTimeout(function () {
                $('#toggle-nav').removeClass('nav-close');
            }, 550);
        }
    });
});