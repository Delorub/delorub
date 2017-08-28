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

  $('.search_category').selectize({
    maxItems: 1,
    valueField: 'id',
    labelField: 'title',
    searchField: 'title',
    options: [],
    create: false,
    onDropdownClose: function () {
      if (this.items.length === 0) {
        this.clearOptions()
      }
    },
    onChange: function () {
      $('.form_search_categories').submit()
    },
    load: function (query, callback) {
      console.log('222');
      if (!query.length) {
        console.log(query.length)
        this.clearOptions()
        return
      }
      $.ajax({
        url: $('.search_category').attr('data_url'),
        type: 'POST',
        data: {search: query},
        success: function (res) {
          console.log(res)
          callback(res.categories)
        }
      })
    }
  })
})
