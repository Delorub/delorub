import Tether from 'tether'

export default {
  data: function () {
    return {
      popoverTether: null
    }
  },
  methods: {
    showTooltip (elementId) {
      let content = document.querySelector('.dr-popover-data[data-for=' + elementId + ']')
      if (!content) return
      let popover = document.querySelector('.dr-popover')
      let area = content.parentElement
      let target = document.getElementById(elementId)

      if (!popover || !target || area.offsetParent === null) {
        return
      }

      popover.classList.remove('hidden')
      popover.style.width = (area.offsetWidth - 34) + 'px'
      popover.innerHTML = content.innerHTML
      if (this.popoverTether === null) {
        this.popoverTether = new Tether({
          element: popover,
          target: target,
          attachment: 'middle left',
          targetAttachment: 'middle right',
          constraints: [{
            to: area,
            pin: true
          }]
        })
      } else {
        this.popoverTether.target = target
        this.popoverTether.position()
      }
    },
    positionPopover () {
      if (this.popoverTether !== null) {
        this.popoverTether.position()
      }
    },
  }
}
