<template lang="pug">
  span(:class="classObject")
    a(:href="generateUrl(page)") {{ _label }}
</template>
<script>
export default {
  props: ['page', 'active', 'next', 'prev', 'ellipsis'],
  methods: {
    generateUrl (page) {
      if (this.ellipsis) return '#'
      return this.pageUrl + this.pageParam(page)
    },
    pageParam (page) {
      return '?page=' + page
    }
  },
  computed: {
    _label () {
      if (this.ellipsis) {
        return '…'
      }
      if (this.prev) {
        return '‹ Назад'
      }
      if (this.next) {
        return 'Далее ›'
      }
      return this.page
    },
    classObject: function () {
      return {
        prev: this.prev,
        next: this.next,
        current: this.active,
        disabled: this.ellipsis
      }
    },
    pageUrl () {
      return window.location.pathname
    }
  }
}
</script>
