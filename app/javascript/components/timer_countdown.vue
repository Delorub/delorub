<template>
  <b>{{showTime}}</b>
</template>
<script>
export default {
  props: ['expire_date'],
  data: function () {
    return {
      now: Math.trunc((new Date()).getTime() / 1000),
      distance: (Math.trunc(Date.parse(this.expire_date) / 1000) - Math.trunc((new Date()).getTime() / 1000))
    }
  },
  ready: function () {
    window.setInterval(() => {
      this.now = Math.trunc((new Date()).getTime() / 1000)
    }, 1000)
  },
  computed: {
    seconds () {
      return (this.distance) % 60
    },
    minutes () {
      return Math.trunc((this.distance) / 60) % 60
    },
    hours () {
      return Math.trunc((this.distance) / 60 / 60) % 24
    },
    pad (d) {
      return (d < 10) ? '0' + d.toString() : d.toString()
    },
    showTime () {
      if (this.distance < 0) {
        return ' истекло'
      } else {
        return this.hours + ':' + this.minutes + ':' + this.seconds
      }
    }
  }
}
</script>
