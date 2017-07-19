import $ from 'jquery'
import 'bootstrap-slider/dist/bootstrap-slider.js'
import 'bootstrap-slider/dist/css/bootstrap-slider.css'
import 'app'

$('#ex1').slider({
  formatter: function (value) {
    return 'Current value: ' + value
  }
})

$('#ex2').slider({
  formatter: function (value) {
    return 'Current value: ' + value
  }
})
