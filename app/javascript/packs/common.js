import 'app'
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'

$('div.dr-authorized-user').hover(function () {
  $('div.dr-authorized-user__dropdown').stop(true, true).delay(100).fadeIn(300)
}, function () {
  $('div.dr-authorized-user__dropdown').stop(true, true).delay(100).fadeOut(300)
})
