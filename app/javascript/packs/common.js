import $ from 'jquery'
import 'bootstrap-slider/dist/bootstrap-slider.js'
import 'bootstrap-slider/dist/css/bootstrap-slider.css'
import 'bootstrap-datepicker/dist/css/bootstrap-datepicker.css'
import 'bootstrap-datepicker/dist/js/bootstrap-datepicker.js'
import 'bootstrap/dist/js/bootstrap.js'
import 'ion-rangeslider/js/ion.rangeSlider.js'
import 'ion-rangeslider/css/ion.rangeSlider.css'
import 'ion-rangeslider/css/ion.rangeSlider.skinHTML5.css'
import 'app'

$('#ex2').slider({
  formatter: function (value) {
    return 'Current value: ' + value
  }
})

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

$(function () {
  $('[data-toggle="popover"]').popover()
})

$('.datepicker').datepicker({
  format: 'mm/dd/yyyy',
  startDate: '-3d'
})
