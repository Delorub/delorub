import 'app'
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap.js'
import 'jquery-ujs'
import Chart from 'chart.js'

$(function () {
  $('div.dr-authorized-user').hover(function () {
    $('div.dr-authorized-user__dropdown').stop(true, true).delay(100).fadeIn(300)
  }, function () {
    $('div.dr-authorized-user__dropdown').stop(true, true).delay(100).fadeOut(300)
  })

  $('.rs-switch').on('click', function () {
    window.location = $(this).data('navigate-to')
  })

  $('.flash').each(function () {
    var flashElement = $(this)
    $('.flash-close', this).on('click', function () {
      flashElement.remove()
    })
  })
})

var ctx = document.getElementById('myChart').getContext('2d')
var myChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    datasets: [{
      label: 'Дата: 01.04.2018',
      data: [2, 5, 7.5, 11, 17, 25, 33, 57, 85, 128],
      backgroundColor: [
        '#00bfd8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8'
      ],
      borderColor: [
        '#00bfd8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8',
        '#e6e8e8'
      ],
      borderWidth: 1
    }]
  },
  options: {
    tooltip: 'average',
    cornerRadius: '0',
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  }
})
