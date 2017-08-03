import 'app'
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'
import 'ion-rangeslider/js/ion.rangeSlider.js'
import 'ion-rangeslider/css/ion.rangeSlider.css'
import 'ion-rangeslider/css/ion.rangeSlider.skinHTML5.css'
import 'eonasdan-bootstrap-datetimepicker'
import 'selectize'

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

$('.markup-select').selectize()

$('.markup-datepicker').datetimepicker()
