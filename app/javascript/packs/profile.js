import $ from 'jquery'

$(document).ready(function () {
  $('.profile_form_sorting input[type="checkbox"]').on('change', function (e) {
    $('.profile_form_sorting').submit()
  })

  $('.show_contacts').on('click', function (e) {
    e.preventDefault()
    $(this).hide()
    $('.performer-profile-main__contacts, .master-card-description__phone, .task-profile-card__contacts').show()
  })

  $('.category_desc_accordion').on('click', function (e) {
    e.preventDefault()
    var bottomText = $(this).closest('.bottom-text')
    bottomText.empty().append(bottomText.attr('data-text'))
  })
})
