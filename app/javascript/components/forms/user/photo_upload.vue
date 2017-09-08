<template lang="pug">
  div(ref="dropzone")
    div.dr-profile-card__image.dr-profile-card__image--margin-top
      img(alt="" :src="imageSrc")
      div.dr-profile-card__image-link(v-show="!uploading")
        a.link-default.openLink(href="#") Изменить
      slot(name="input" scope="props" :id="imageId" v-if="imageId !== undefined")
</template>
<script>
  import Dropzone from 'dropzone'
  Dropzone.autoDiscover = false

  export default {
    props: [
      'url', 'image', 'id'
    ],
    data: function () {
      return {
        imageSrc: this.image,
        imageId: this.id,
        uploading: false
      }
    },
    mounted () {
      this.dropzone = new Dropzone(this.$refs.dropzone, {
        url: this.url,
        maxFiles: 1,
        acceptedFiles: 'image/*',
        maxFilesize: 1,
        autoDiscover: false,
        clickable: '.openLink',
        addedfile: function () {},
        error: function () {}
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
    }
  }
</script>

<style lang="scss">
  @import '../../../stylesheets/_vars.sass';
  @import 'dropzone/dist/dropzone.css';
</style>
