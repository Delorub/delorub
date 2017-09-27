import Chart from 'chart.js'

Chart.defaults.global.pointHitDetectionRadius = 1

Chart.pluginService.register({
  afterDatasetsDraw (element) {
    let chart = element.chart
    let ctx = chart.ctx

    ctx.restore()

    if (chart.scales['y-axis-0'].options.customLabel.display) {
      // Y axis custom label
      ctx.font = '14px sans-serif'
      ctx.fillStyle = '#4a4a4a'
      let text = chart.scales['y-axis-0'].options.customLabel.labelString
      let textX = chart.scales['x-axis-0'].left + 10
      let textY = chart.scales['y-axis-0'].top - 14
      ctx.fillText(text, textX, textY)

      let arrowSize = 12
      let triangleWidth = 8
      let lineWidthOffset = 0.5

      // Y axis triangle
      ctx.beginPath()
      ctx.fillStyle = '#e6e3e3'
      ctx.moveTo(chart.scales['y-axis-0'].right + (triangleWidth / 2) + lineWidthOffset, chart.scales['y-axis-0'].top - arrowSize)
      ctx.lineTo(chart.scales['y-axis-0'].right - (triangleWidth / 2) + lineWidthOffset, chart.scales['y-axis-0'].top - arrowSize)
      ctx.lineTo(chart.scales['y-axis-0'].right + lineWidthOffset, chart.scales['y-axis-0'].top - triangleWidth - arrowSize)
      ctx.fill()
      ctx.closePath()

      // Y axis line to triangle
      ctx.beginPath()
      ctx.strokeStyle = '#e6e3e3'
      ctx.moveTo(chart.scales['y-axis-0'].right + lineWidthOffset, chart.scales['y-axis-0'].top)
      ctx.lineTo(chart.scales['y-axis-0'].right + lineWidthOffset, chart.scales['y-axis-0'].top - arrowSize)
      ctx.stroke()
      ctx.closePath()
    }

    if (chart.scales['x-axis-0'].options.customLabel.display) {
      // X axis right custom label
      ctx.font = '14px sans-serif'
      ctx.fillStyle = '#4a4a4a'
      let text = chart.scales['x-axis-0'].options.customLabel.labelString
      let textX = chart.scales['x-axis-0'].right + 30
      let textY = chart.scales['x-axis-0'].top
      ctx.fillText(text, textX, textY)

      let arrowSize = 12
      let triangleWidth = 8
      let lineWidthOffset = 0.5

      // X axis triangle
      ctx.beginPath()
      ctx.fillStyle = '#e6e3e3'
      ctx.moveTo(chart.scales['x-axis-0'].right + arrowSize, chart.scales['x-axis-0'].top - (triangleWidth / 2) + lineWidthOffset)
      ctx.lineTo(chart.scales['x-axis-0'].right + arrowSize, chart.scales['x-axis-0'].top + (triangleWidth / 2) + lineWidthOffset)
      ctx.lineTo(chart.scales['x-axis-0'].right + arrowSize + triangleWidth, chart.scales['x-axis-0'].top + lineWidthOffset)
      ctx.fill()
      ctx.closePath()

      // X axis line to triangle
      ctx.beginPath()
      ctx.strokeStyle = '#e6e3e3'
      ctx.moveTo(chart.scales['x-axis-0'].left, chart.scales['x-axis-0'].top + lineWidthOffset)
      ctx.lineTo(chart.scales['x-axis-0'].right + arrowSize, chart.scales['x-axis-0'].top + lineWidthOffset)
      ctx.stroke()
      ctx.closePath()
    }

    // Right final horizontal line
    ctx.beginPath()
    ctx.strokeStyle = '#e6e3e3'
    ctx.moveTo(chart.scales['x-axis-0'].right + 0.5, chart.scales['y-axis-0'].bottom + 10)
    ctx.lineTo(chart.scales['x-axis-0'].right + 0.5, chart.scales['y-axis-0'].top)
    ctx.stroke()
    ctx.closePath()

    let lineWidthOffset = 0.5
    let scaleY = (chart.scales['y-axis-0'].bottom - chart.scales['y-axis-0'].top) / chart.scales['y-axis-0'].max

    chart.data.datasets.forEach((dataset) => {
      dataset.data.forEach((data, i) => {
        let ctx = chart.ctx

        ctx.font = '12px sans-serif'
        ctx.textBaseline = 'middle'
        ctx.fillStyle = dataset.customTextColor[i]

        let text = data + '₽'
        let textX = chart.scales['x-axis-0'].getPixelForTick(i) - (chart.ctx.measureText(text).width / 2)
        let textY = chart.scales['y-axis-0'].bottom - (data * scaleY) - 14

        ctx.fillText(text, textX, textY)
      })
    })

    let tickOffset = (chart.scales['x-axis-0'].right - chart.scales['x-axis-0'].left) / chart.scales['x-axis-0'].ticks.length
    chart.scales['x-axis-0'].ticks.forEach((tick, i) => {
      let ctx = chart.ctx

      ctx.beginPath()
      ctx.strokeStyle = '#e6e3e3'
      ctx.moveTo(chart.scales['x-axis-0'].left + ((i + 1) * tickOffset) + lineWidthOffset, chart.scales['y-axis-0'].top - 4)
      ctx.lineTo(chart.scales['x-axis-0'].left + ((i + 1) * tickOffset) + lineWidthOffset, chart.scales['y-axis-0'].top)
      ctx.stroke()
      ctx.closePath()
    })

    chart.scales['y-axis-0'].ticks.forEach((tick, i) => {
      let ctx = chart.ctx

      ctx.beginPath()
      ctx.strokeStyle = '#e6e3e3'
      ctx.moveTo(chart.scales['x-axis-0'].right + lineWidthOffset, chart.scales['y-axis-0'].getPixelForTick(i) + lineWidthOffset)
      ctx.lineTo(chart.scales['x-axis-0'].right + lineWidthOffset + 11, chart.scales['y-axis-0'].getPixelForTick(i) + lineWidthOffset)
      ctx.stroke()
      ctx.closePath()

      ctx.beginPath()
      ctx.strokeStyle = '#ffffff'
      ctx.moveTo(chart.scales['x-axis-0'].left, chart.scales['y-axis-0'].getPixelForTick(i) + lineWidthOffset)
      ctx.lineTo(chart.scales['x-axis-0'].left - 10, chart.scales['y-axis-0'].getPixelForTick(i) + lineWidthOffset)
      ctx.stroke()
      ctx.closePath()
    })

    ctx.save()
  }
})

export default Chart
