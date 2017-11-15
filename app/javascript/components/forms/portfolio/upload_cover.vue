<template lang="pug">
  div(ref="dropzone")
    p.dr-h2.margin-bottom-20 Обложка альбома
    div.dr-profile-card__image-error(v-if="errorMessage") {{ errorMessage }}
    .align-center
      .album-cover-image
        div(v-if="imageSrc !== undefined" @mouseenter="isShowCloseIcon = true" @mouseleave="isShowCloseIcon = false")
          img(alt="" :src="imageSrc")
          .album-image-links(v-show="isShowCloseIcon")
            a.album-image-close(href="#" @click.prevent="removeCover")
              .album-tooltip-close Удалить
        input#cover_upload_visible(readonly="1" type="text" value="+" v-show="imageSrc === undefined")
      .album-cover-tooltip
        p Загрузите фаил
        p.gray-text
          | Поддерживаемые форматы файлов:
          span.dr-h5 jpg, png, bmp.
        p.gray-text
          | Максимальный размер файла -
          span.dr-h5 10мб
    slot(name="input" :id="imageId" v-if="imageId !== undefined")
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
      errorMessage: undefined,
      prevFile: undefined,
      isShowCloseIcon: false
    }
  },
  mounted () {
    this.dropzone = new Dropzone(this.$refs.dropzone, {
      url: this.url,
      maxFiles: 1,
      acceptedFiles: 'image/jpeg,image/png',
      maxFilesize: 2,
      autoDiscover: false,
      clickable: '#cover_upload_visible',
      addedfile: function () {},
      error: function () {},
      addRemoveLinks: true,
      dictInvalidFileType: 'Формат файла не поддерживается (поддерживаемые форматы файлов: png, jpg, jpeg, bmp)'
    })

    this.dropzone.on('maxfilesexceeded', function (file) {
      this.removeAllFiles()
      this.addFile(file)
    })

    this.dropzone.on('addedfile', () => {
      if (typeof this.prevFile !== 'undefined') {
        this.dropzone.removeFile(this.prevFile)
      }
    })

    this.dropzone.on('sending', () => {
      this.uploading = true
    })

    this.dropzone.on('success', (file, response) => {
      this.prevFile = file
      this.imageSrc = response.cover_url
      this.imageId = response.id
      this.errorMessage = undefined
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
  },
  methods: {
    removeCover () {
      this.imageSrc = undefined
      this.imageId = null
    }
  }
}
</script>

  <style lang="scss">
    @import '../../../stylesheets/_vars.sass';
    @import 'dropzone/dist/dropzone.css';
  </style>
