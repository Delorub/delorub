import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import $ from 'jquery';
import 'imports-loader?jQuery=jquery!owl.carousel';

$(document).ready(function() {
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
