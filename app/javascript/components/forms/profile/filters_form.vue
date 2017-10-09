<template lang="pug">
  label(@click.present = "redirectToUrl")
    input(type="checkbox" :checked="checkedValue")
    span.checkbox-custom
    | Новые&nbsp;исполнители
</template>
<script>
  export default {
    props: ['currentUrl', 'orderValue'],
    methods: {
      redirectToUrl () {
        window.location.href = this.redirectUrl
      }
    },
    computed: {
      checkedValue () {
        return (this.orderValue !== undefined && parseInt(this.orderValue) === 1)
      },
      redirectUrl () {
        return this.currentUrl + (!this.checkedValue ? '?direction_created=1' : '')
      }
    }
  }
</script>
