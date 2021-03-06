export default {
  mounted () {
    window.setInterval(() => {
      this.countdownTick()
    }, 1000)
  },
  data: function () {
    return {
      now: Math.round((new Date()).getTime() / 1000)
    }
  },
  methods: {
    countdownTick: function () {
      this.now = Math.round((new Date()).getTime() / 1000)
    },
    countdownTo: function (value, seconds) {
      if (value === null || value === undefined) {
        return 0
      }

      return Math.max(seconds - (this.now - Math.round(value / 1000)), 0)
    },
    formatCountdown: function (value) {
      let date = new Date(null)
      date.setSeconds(value)
      return date.toISOString().substr(14, 5)
    }
  }
}
