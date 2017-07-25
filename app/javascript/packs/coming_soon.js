import $ from 'jquery'

$(document).ready(function () {
  $('a[href="#"]').on('click', function (e) {
    e.preventDefault()
    window.location = '/coming-soon'
  })
})
