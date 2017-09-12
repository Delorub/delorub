<template lang="pug">
  div(ref="dropzone")
    div.dr-profile-card__image.dr-profile-card__image--margin-top
      img(alt="" :src="imageSrc")
      div.dr-profile-card__image-link(v-show="!uploading")
        a.link-default.openLink(href="#") Изменить
      slot(name="input" :id="imageId" v-if="imageId !== undefined")
      div.dr-profile-card__image-error(v-if="errorMessage") {{ errorMessage }}
</template>
<script>
  import Dropzone from 'lib/dropzone'

  export default {
    props: [
      'url', 'image', 'id'
    ],
    data: function () {
      return {
        imageSrc: this.image,
        imageId: this.id,
        uploading: false,
        errorMessage: undefined
      }
    },
    mounted () {
      this.dropzone = new Dropzone(this.$refs.dropzone, {
        url: this.url,
        maxFiles: 1,
        acceptedFiles: 'image/*',
        maxFilesize: 10,
        autoDiscover: false,
        clickable: '.openLink',
        addedfile: function () {},
        error: function () {},
        dictFileTooBig: 'Превышен размер изображения! Максимальный размер изображения {{maxFilesize}} мб'
      })

      this.dropzone.on('maxfilesexceeded', function (file) {
        this.removeAllFiles()
        this.addFile(file)
      })

      this.dropzone.on('sending', () => {
        this.uploading = true
      })

      this.dropzone.on('success', (file, response) => {
        this.imageSrc = response.photo_url
        this.imageId = response.id
      })

      this.dropzone.on('complete', () => {
        this.uploading = false
      })

      this.dropzone.on('error', (file, message, xhr) => {
        if (xhr !== undefined) {
          this.errorMessage = 'Ошибка сервера'
        } else {
          this.errorMessage = message
        }
      })
    }
  }
</script>

<style lang="scss">
  @import '../../../stylesheets/_vars.sass';
  @import 'dropzone/dist/dropzone.css';
</style>
