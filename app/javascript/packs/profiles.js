import $ from 'jquery'

$(document).ready(function () {
  $('.profile_form_sorting input[type="checkbox"]').on('change', function (e) {
    $('.profile_form_sorting').submit();
  })
})
