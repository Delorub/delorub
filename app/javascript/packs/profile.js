import $ from 'jquery'

$(document).ready(function () {
  $('.profile_form_sorting input[type="checkbox"]').on('change', function (e) {
    $('.profile_form_sorting').submit()
  })

  $('.show_contacts').on('click', function (e) {
    e.preventDefault()
    $(this).hide()
    $('.performer-profile-main__contacts, .task-profile-card__contacts').show()
  })

  $('.show_contacts_all').on('click', function (e) {
    e.preventDefault()
    $(this).hide()
    $(this).closest('div').find('.performer-profile-main__contacts').show()
  })

  $('.category_desc_accordion').on('click', function (e) {
    e.preventDefault()
    var bottomText = $(this).closest('.bottom-text')
    bottomText.empty().append(bottomText.attr('data-text'))
  })

  $('.search_categories input').on('keydown', function (e) {
    if ((e.which === 13) && $('.search_categories ul.multiselect__content li').length <= 1) {
      $(this).closest('form').submit()
    }
  })
})
