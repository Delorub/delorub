import $ from 'jquery'
import 'bootstrap-slider/dist/bootstrap-slider.js'
import 'bootstrap-slider/dist/css/bootstrap-slider.css'
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
    from: 1,
    values: [
      '500', '1 500',
      '5 000', '15 000',
      '50 000', '100 000',
      '200 000', '300 000'
    ]
  })
