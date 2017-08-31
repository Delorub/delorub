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

  function pad (d) {
    return (d < 10) ? '0' + d.toString() : d.toString()
  }

  setInterval(function () {
    $(".task-card-refinement__time--quickly input[name='expired_date']").each(function (e) {
      var taskCard = $(this).closest('.task-card-refinement__time--quickly')
      var countDownDate = new Date($(this).val()).getTime()
      var now = new Date().getTime()
      var distance = countDownDate - now
      var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
      var seconds = Math.floor((distance % (1000 * 60)) / 1000)
      taskCard.find('span').text(' ' + pad(hours) + ':' + pad(minutes) + ':' + pad(seconds))
      if (distance < 0) {
        taskCard.find('span').text(' истекло')
      }
    })
  }, 1000)
})
