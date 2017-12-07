<script>
  export default {
    methods: {
      checkTextField (e) {
        e.target.value = e.target.value.replace(/[^a-zA-Zа-яА-Я-]/g, '')
      }
    }
  }
</script>
