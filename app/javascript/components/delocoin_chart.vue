<template lang="pug">
  div
    .tooltip.tooltip-top(ref="tooltip" style="display: none; opacity: 1;")
      .tooltip-inner(ref="tooltipText")
    .dr-block-style.dr-block-style--margin-top(style="padding: 0px" ref="asd")
      canvas(ref="chart")
</template>

<script>
  import Chart from 'lib/custom_chart'

  export default {
    props: ['stepsList'],
    data: function () {
      return {
        chart: null
      }
    },
    methods: {
      chartData () {
        return {
          labels: this.stepsList.map(e => e.number),
          datasets: [{
            data: this.stepsList.map(e => e.rate),
            dates: this.stepsList.map(e => e.date_from),
            borderWidth: 1,
            customTextColor: this.stepsList.map((e) => {
              if (e.is_future) return '#d1d1d1'
              return '#4a4a4a'
            }),
            backgroundColor: this.stepsList.map((e) => {
              if (e.is_current) return '#00bfd8'
              if (e.is_past) return '#9bd4f4'
              return '#e6e8e8'
            }),
            hoverBackgroundColor: this.stepsList.map((e) => {
              if (e.is_current) return '#00bfd8'
              if (e.is_past) return '#9bd4f4'
              return '#e6e8e8'
            }),
            borderColor: this.stepsList.map((e) => {
              if (e.is_current) return '#00bfd8'
              if (e.is_past) return '#9bd4f4'
              return '#e6e8e8'
            }),
            hoverBorderColor: this.stepsList.map((e) => {
              return '#519dc7'
            })
          }]
        }
      },
      customTooltips (tooltip) {
        if (tooltip.opacity === 0) {
          this.$refs.tooltip.style.display = 'none'
          return
        }

        this.$refs.tooltip.style.display = 'block'

        function getBody (bodyItem) {
          return bodyItem.lines + bodyItem.after
        }

        if (tooltip.body) {
          let titleLines = tooltip.title || []
          let bodyLines = tooltip.body.map(getBody)
          let innerHtml = ''

          titleLines.forEach((title) => {
            innerHtml += title
            innerHtml += '<br>'
          })

          bodyLines.forEach((body, i) => {
            innerHtml += body
            innerHtml += '<br>'
          })

          this.$refs.tooltipText.innerHTML = innerHtml
        }

        var positionY = this.$refs.asd.offsetTop
        var positionX = this.$refs.asd.offsetLeft

        this.$refs.tooltip.style.left = (positionX + tooltip.caretX - (this.$refs.tooltip.clientWidth / 2)) + 'px'
        this.$refs.tooltip.style.top = (positionY + tooltip.caretY - (this.$refs.tooltip.clientHeight) - 5) + 'px'
      }
    },
    mounted () {
      this.chart = new Chart(this.$refs.chart.getContext('2d'), {
        type: 'bar',
        data: this.chartData(),
        options: {
          layout: {
            padding: {
              left: 40,
              right: 250,
              top: 65,
              bottom: 40
            }
          },
          legend: {
            display: false
          },
          tooltips: {
            enabled: false,
            mode: 'index',
            position: 'average',
            custom: this.customTooltips,
            callbacks: {
              title: function ([tooltipItem], data) {
                var date = data['datasets'][0]['dates'][tooltipItem['index']]
                return 'Дата: ' + date
              },
              afterTitle: function ([tooltipItem], data) {
                return 'Текущий этап: ' + 1
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
              customLabel: { display: true, labelString: 'Цена' },
              ticks: { fontColor: '#4a4a4a', min: 0, beginAtZero: true, stepSize: 25 },
              gridLines: { color: '#e6e3e3' }
            }],
            xAxes: [{
              display: true,
              ticks: { fontColor: '#4a4a4a' },
              customLabel: { display: true, labelString: 'Этапы удорожания' },
              gridLines: { color: '#e6e3e3' }
            }]
          }
        }
      })
    }
  }
</script>
