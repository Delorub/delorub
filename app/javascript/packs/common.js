import 'app'
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'
import Slideout from 'slideout/dist/slideout.js'
import 'jquery-ujs'

$(function () {
  $('div.dr-authorized-user').hover(function () {
    $('div.dr-authorized-user__dropdown').stop(true, true).delay(100).fadeIn(300)
  }, function () {
    $('div.dr-authorized-user__dropdown').stop(true, true).delay(100).fadeOut(300)
  })

  $('.rs-switch').on('click', function () {
    window.location = $(this).data('navigate-to')
  })

  $('.flash').each(function () {
    var flashElement = $(this)
    $('.flash-close', this).on('click', function () {
      flashElement.remove()
    })
  })

  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

  /* eslint no-unused-vars: off */
  /* eslint no-undef: off */
  var slideout = new Slideout({
    'panel': document.getElementById('panel'),
    'menu': document.getElementById('menu'),
    'padding': 230,
    'tolerance': 70
  })
})
