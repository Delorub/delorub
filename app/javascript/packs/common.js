import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'
import 'ion-rangeslider/js/ion.rangeSlider.js'
import 'ion-rangeslider/css/ion.rangeSlider.css'
import 'ion-rangeslider/css/ion.rangeSlider.skinHTML5.css'
import 'app'

$('#budget_slider').ionRangeSlider(
  {
    grid: true,
    from: 1,
    values: [
      '500', '1 500',
      '5 000', '15 000',
      '50 000', '100 000',
      '200 000', '300 000'
    ]
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

$(function () {
  $('[data-toggle="popover"]').popover()
})
