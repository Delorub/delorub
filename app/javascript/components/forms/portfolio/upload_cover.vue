<template lang="pug">
  div(ref="dropzone")
    p.dr-h2.mb-3 Обложка альбома
    .align-center
      .album-cover-image
        div(v-if="imageSrc !== undefined" @mouseenter="isShowCloseIcon = true" @mouseleave="isShowCloseIcon = false")
          img(alt="" :src="imageSrc")
          .album-image-success(v-if="isSave")
            svg(height="45" viewbox=("0 0 45 45") width="45" xmlns="http://www.w3.org/2000/svg")
              path(d=("M41.938 11.194a22.382 22.382 0 0 0-8.18-8.18C30.316 1.004 26.556 0 22.478 0s-7.839 1.005-11.282 3.014a22.376 22.376 0 0 0-8.18 8.18C1.005 14.638 0 18.399 0 22.476c0 4.078 1.005 7.838 3.014 11.282a22.382 22.382 0 0 0 8.18 8.18c3.444 2.01 7.205 3.014 11.282 3.014 4.078 0 7.839-1.005 11.283-3.014a22.376 22.376 0 0 0 8.18-8.18c2.008-3.444 3.013-7.204 3.013-11.282s-1.005-7.839-3.014-11.282zm-4.888 7.858L21.16 34.943c-.372.371-.82.556-1.347.556a1.8 1.8 0 0 1-1.317-.556L7.901 24.35c-.35-.351-.526-.79-.526-1.317 0-.546.175-.995.526-1.346l2.664-2.634a1.8 1.8 0 0 1 1.317-.556 1.8 1.8 0 0 1 1.317.556l6.614 6.614 11.94-11.911a1.8 1.8 0 0 1 1.317-.556 1.8 1.8 0 0 1 1.317.556l2.664 2.634c.351.351.526.8.526 1.346 0 .527-.175.966-.527 1.317z") fill="#FFFAFA" fill-opacity="1" fill-rule="nonzero")
          .progress(v-if="isShowProgress")
            .progress-bar(aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" style="width:0%")
          .album-image-links(v-show="isShowCloseIcon")
            a.album-image-close(href="#" @click.prevent="removeCover")
              .album-tooltip-close Удалить
        input#cover_upload_visible(readonly="1" type="text" value="+" v-show="imageSrc === undefined")
      .album-cover-description
        .album-cover-error(v-if="errorMessage !== undefined")
          p(v-html="errorMessage")
        .album-cover-tooltip
          p Загрузите фаил
          p.gray-text
            | Поддерживаемые форматы файлов:
            span.dr-h5 &nbspjpg, png, bmp.
          p.gray-text
            | Максимальный размер файла -
            span.dr-h5 &nbsp10Мб
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
      isSave: false,
      isShowProgress: false,
      errorMessage: undefined,
      isShowCloseIcon: false
    }
  },
  mounted () {
    this.dropzone = new Dropzone(this.$refs.dropzone, {
      url: this.url,
      thumbnailWidth: 183,
      thumbnailHeight: 176,
      maxFiles: 1,
      acceptedFiles: 'image/jpeg, image/png, image/bmp, image/jpg',
      maxFilesize: 10,
      autoDiscover: false,
      previewContainer: '#preview',
      clickable: '#cover_upload_visible',
      addedfile: function () {},
      error: function () {},
      prevFile: undefined,
      dictInvalidFileType: 'Недопустимый формат файла, поддерживаемые форматы: <span class="dr-h5"> jpg, png, bmp</span>'
    })

    this.dropzone.on('maxfilesexceeded', function (file) {
      this.removeAllFiles()
      this.addFile(file)
    })

    this.dropzone.on('uploadprogress', function (file, progress) {
      var progressBar = document.querySelector('.progress-bar')
      if (progressBar !== null) {
        progressBar.style.width = progress + '%'
      }
    })

    this.dropzone.on('thumbnail', (file, dataUrl) => {
      this.isShowProgress = true
      this.imageSrc = dataUrl
    })

    this.dropzone.on('addedfile', () => {
      this.progressBarPercent = 0
      if (typeof this.prevFile !== 'undefined') {
        this.dropzone.removeFile(this.prevFile)
      }
    })

    this.dropzone.on('success', (file, response) => {
      this.prevFile = file
      this.imageId = response.id
      this.errorMessage = undefined
    })

    this.dropzone.on('complete', () => {
      this.isSave = true
      this.isShowProgress = false
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
      this.isSave = false
    }
  }
}
</script>

  <style lang="scss">
    @import '../../../stylesheets/_vars.sass';
    @import 'dropzone/dist/dropzone.css';
  </style>
