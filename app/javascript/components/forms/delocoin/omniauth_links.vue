<template lang="pug">
  div
    .registration-form__content-circle__header
      | Или зарегистрируйтесь через
    .registration-form__content-circle__item
      a(:href="generateUrl('vkontakte')")
        img.task-card-person__image(alt="vkontakte" src="/images/design/vk.png")
    .registration-form__content-circle__item
      a(:href="generateUrl('facebook')")
        img.task-card-person__image(alt="facebook" src="/images/design/fb.png")
    .registration-form__content-circle__item
      a(:href="generateUrl('odnoklassniki')")
        img.task-card-person__image(alt="odnoklassniki" src="/images/design/ok.png")
</template>
<script>
export default {
  props: ['operation', 'omniauthParams'],
  methods: {
    generateUrl (providerName) {
      return '/users/auth/' + providerName + '?' + this.omniauthParams + '&operation=' + this.operation
    }
  }
}
</script>
