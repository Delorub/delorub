import 'app'
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'

$(function () {
  $('#budget_slider').ionRangeSlider(
    {
      grid: true,
      from: 2,
      values: [
        500, 1000, 2000, 100000
      ],
      prettify: (value) => (
        '<b>Бюджет</b> до ' + value
      )
    })

  $('#budget_slider_tasks').ionRangeSlider(
    {
      type: 'double',
      min: 500,
      max: 10000,
      step: 500,
      grid: true,
      grid_snap: true
    })

  $('[data-toggle="popover"]').popover()
})
