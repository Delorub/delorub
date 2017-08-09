import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'
import 'ion-rangeslider/js/ion.rangeSlider.js'
import 'ion-rangeslider/css/ion.rangeSlider.css'
import 'ion-rangeslider/css/ion.rangeSlider.skinHTML5.css'
import 'eonasdan-bootstrap-datetimepicker'
// import 'eonasdan-bootstrap-datetimepicker/src/sass/bootstrap-datetimepicker-build.scss'
import 'selectize'
import 'app'

$('#budget_slider').ionRangeSlider(
  {
    grid: true,
    from: 2,
    values: [
      '<b>Мелкий бюджет</b> <br/> до 500',
      '<b>Мелкий бюджет</b> <br/> до 1 500',
      '<b>Мелкий бюджет</b> <br/> до 5 000',
      '<b>Средний бюджет</b> <br/> до 15 000',
      '<b>Средний бюджет</b> <br/> до 50 000',
      '<b>Крупный бюджет</b> <br/> до 100 000',
      '<b>Крупный бюджет</b> <br/> до 200 000',
      '<b>Крупный бюджет</b> <br/> от 200 000'
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

$('.markup-select').selectize()

$('.markup-datepicker').datetimepicker()
