<template lang="pug">
  .form-group.required.profile_new_user_first_name
    input.form-control.string.required(
      type="text"
      ref="nameInput"
      placeholder="Ваше имя"
      v-model="inputFirstName"
      name="profile[new_user_attributes][first_name]"
      aria-invalid="true"
    )
</template>

<script>
  export default {
    data () {
      return {
      }
    },
    methods: {
      isLetter (evt) {
        var regex = /[a-zA-Z]/
        if (!regex.test(evt.key)) {
          return false
        }
        return true
      },
      inputFirstName1 (evt) {
        if (!this.isLetter(evt)) {
          evt.preventDefault()
        }
      }
    }
  }
</script>
