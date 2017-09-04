<template>
  <span> {{showTime}}</span>
</template>
<script>
export default {
  props: ['expire_date'],
  mounted () {
    window.setInterval(() => {
      this.now = Math.trunc((new Date()).getTime() / 1000)
    }, 1000)
  },
  data: function () {
    return {
      now: Math.trunc((new Date()).getTime() / 1000)
    }
  },
  computed: {
    distance: function () {
      return (Math.trunc(Date.parse(this.expire_date) / 1000) - this.now)
    },
    seconds () {
      return (this.distance) % 60
    },
    minutes () {
      return Math.trunc((this.distance) / 60) % 60
    },
    hours () {
      return Math.trunc((this.distance) / 60 / 60) % 24
    },
    showTime () {
      if (this.distance < 0) {
        return ' истекло'
      } else {
        return this.pad(this.hours) + ':' + this.pad(this.minutes) + ':' + this.pad(this.seconds)
      }
    }
  },
  methods: {
    pad (d) {
      return (d < 10) ? '0' + d.toString() : d.toString()
    }
  }
}
</script>
