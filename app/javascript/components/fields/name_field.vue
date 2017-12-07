<script>
  export default {
    methods: {
      isLetter (evt) {
        var regex = /[a-zA-Zа-яА-Я]/
        if (!regex.test(evt.key)) {
          return false
        }
        return true
      },
      checkNameFiled (evt) {
        console.log(evt)
        if (!this.isLetter(evt)) {
          evt.preventDefault()
        }
      }
    }
  }
</script>
