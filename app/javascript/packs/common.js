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

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

let ctx = document.getElementById('myChart')
if (ctx !== null) {
  ctx = ctx.getContext('2d')
  // eslint-disable-next-line no-new
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
      datasets: [{
        data: [2, 5, 7.5, 11, 17, 25, 33, 57, 85, 128],
        dates: [
          '01.04.2019',
          '02.04.2019',
          '03.04.2019',
          '04.04.2019',
          '05.04.2019',
          '06.04.2019',
          '07.04.2019',
          '08.04.2019',
          '09.04.2019',
          '01.04.2019'
        ],
        backgroundColor: [
          '#9bd4f4',
          '#9bd4f4',
          '#00bfd8',
          '#e6e8e8',
          '#e6e8e8',
          '#e6e8e8',
          '#e6e8e8',
          '#e6e8e8',
          '#e6e8e8',
          '#e6e8e8'
        ]
      }]
    },
    options: {
      legend: {
        display: false
      },
      tooltips: {
        cornerRadius: 3,
        position: 'nearest',
        caretPadding: 15,
        caretSize: 10,
        titleMarginBottom: 10,
        xPadding: 25,
        yPadding: 15,
        backgroundColor: '#4a4a4a',
        titleFontSize: 14,
        titleFontStyle: 'normal',
        bodyFontSize: 14,
        callbacks: {
          title: function ([tooltipItem], data) {
            var date = data['datasets'][0]['dates'][tooltipItem['index']]
            return 'Дата: ' + date
          },
          afterTitle: function ([tooltipItem], data) {
            var stage = data['labels'][tooltipItem['index']]
            return 'Этап: ' + stage
          },
          label: function (tooltipItem, data) {
          },
          afterLabel: function (tooltipItem, data) {
            var count = data['datasets'][0]['data'][tooltipItem['index']]
            return 'Стоимость Delocoin: ' + count
          }
        }
      },
      scales: {
        yAxes: [{
          display: true,
          scaleLabel: { display: true, labelString: 'Цена' },
          ticks: { fontColor: '#4a4a4a', min: 0, beginAtZero: true, stepSize: 25 },
          gridLines: { color: '#e6e3e3' }
        }],
        xAxes: [{
          display: true,
          ticks: { fontColor: '#4a4a4a' },
          scaleLabel: { display: true, labelString: 'Этапы удорожания' },
          gridLines: { color: '#e6e3e3' }
        }]
      }
    }
  })
}
