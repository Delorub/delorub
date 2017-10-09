import 'app'
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'
import Hammer from 'hammerjs/hammer.js'
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
})

var sidebar = document.getElementById('#sidebar')

sidebar.get('swipe').set({ direction: Hammer.DIRECTION_VERTICAL })

Hammer(sidebar).on('swiperight', function () {
  $(this).animate({left: '+=100'}, 500)
})
