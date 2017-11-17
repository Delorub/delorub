<template lang="pug">
  div
    template(v-for="(file, index) in internalValue")
      slot(name="file" :file="file" v-if="file.id !== undefined && !file.isDeleted")
      template(v-if="file.isDeleted")
        .album-image-remove
          span Удалено.&nbsp
            a.link-default(@click.prevent="restoreFile(file.id, index)" href="#") Восстановить
      template(v-else)
        .album-image-add(:key="file.id")
          .album-image-item(@mouseenter="file.isShowCloseIcon = true" @mouseleave="file.isShowCloseIcon = false")
            .album-image-success(v-if="file.isSave")
              svg(height="45" viewbox=("0 0 45 45") width="45" xmlns="http://www.w3.org/2000/svg")
                path(d=("M41.938 11.194a22.382 22.382 0 0 0-8.18-8.18C30.316 1.004 26.556 0 22.478 0s-7.839 1.005-11.282 3.014a22.376 22.376 0 0 0-8.18 8.18C1.005 14.638 0 18.399 0 22.476c0 4.078 1.005 7.838 3.014 11.282a22.382 22.382 0 0 0 8.18 8.18c3.444 2.01 7.205 3.014 11.282 3.014 4.078 0 7.839-1.005 11.283-3.014a22.376 22.376 0 0 0 8.18-8.18c2.008-3.444 3.013-7.204 3.013-11.282s-1.005-7.839-3.014-11.282zm-4.888 7.858L21.16 34.943c-.372.371-.82.556-1.347.556a1.8 1.8 0 0 1-1.317-.556L7.901 24.35c-.35-.351-.526-.79-.526-1.317 0-.546.175-.995.526-1.346l2.664-2.634a1.8 1.8 0 0 1 1.317-.556 1.8 1.8 0 0 1 1.317.556l6.614 6.614 11.94-11.911a1.8 1.8 0 0 1 1.317-.556 1.8 1.8 0 0 1 1.317.556l2.664 2.634c.351.351.526.8.526 1.346 0 .527-.175.966-.527 1.317z") fill="#FFFAFA" fill-opacity="1" fill-rule="nonzero")
            .album-image-links(v-if="checkIfAllowDelete(file)" @click.prevent="deleteFile(file.id, index)")
              a.album-image-close(href="#")
                .album-tooltip-close Удалить
            template(v-if="file.isIncorrectFormat")
              .album-image-unacceptable
            template(v-else)
              img(:src="file.preview_url" v-bind:class="file.hasError ? 'album-image-mask' : ''")
              .progress(v-if="hasProgressBar(file)")
                .progress-bar(aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" :style="progressBarWidth(file)")
          template(v-if="!file.hasError && !file.isDeleted")
            .form-group.album-image-textarea
              textarea.form-control(placeholder=("Описание фотографии") rows="5" v-model="file.description")
          template(v-else)
            .album-image-error
              p(v-if="file.isServerError")
                | Ошибка загрузки изображения,&nbsp
                a.link-default(href="#" @click.prevent="downloadAgain(file)") попробовать снова
              p(v-else v-html="file.errorMessage")
    .album-image-upload
      input#image_upload_hidden(name="file" type="file" multiple @change="handleFileSelect")
      input#image_upload_visible(onclick="document.getElementById('image_upload_hidden').click();" readonly="1" type="text" value=("Прикрепить изображение"))
</template>
<script>
import axios from 'axios'

export default {
  props: ['value', 'userToken'],
  data: function () {
    return {
      internalValue: [],
      accessToken: this.userToken
    }
  },
  mounted () {
    this.value.every((e) => this.internalValue.push(Object.assign(e, { isShowCloseIcon: false })))
  },
  methods: {
    handleFileSelect (event) {
      var files = event.target.files || event.dataTransfer.files
      for (var i = 0; i < files.length; i++) {
        this.createImage(files[i])
      }
    },
    createImage (file) {
      var vm = this
      var reader = new window.FileReader()

      var img = new window.Image()
      reader.onload = function (e) {
        img.src = e.target.result

        img.onload = function () {
          vm.sendingToValidation(vm.pushInternalValue(file, vm.resizeImage(img, file)))
        }
        img.onerror = function () {
          vm.sendingToValidation(vm.pushInternalValue(file, e.target.result))
        }
      }
      reader.readAsDataURL(file)
    },
    sendingToValidation (object) {
      if (object === null) return
      this.validateFile(object)

      if (object.hasError) return
      this.saveFile(object)
    },
    progressBarWidth (object) {
      return 'width:' + object.percentLoader + '%'
    },
    validateFile (object) {
      if (!object.file.type.match(/.(bmp|jpeg|png|jpg)$/i)) {
        this.fileSetError(object, 'Недопустимый формат файла, поддерживаемые форматы: jpg, png, bmp', true)
      } else if (this.fileSize(object.file) > 10) {
        this.fileSetError(object, 'Файл слишком большой (максимальный размер файла - 10 Мб)')
      }
    },
    fileSize (file) {
      return file.size / (1024 * 1024)
    },
    fileSetError (object, message, isIncorrectFormat = false) {
      object.hasError = true
      object.errorMessage = message
      object.isIncorrectFormat = isIncorrectFormat
    },
    hasProgressBar (object) {
      return object.isSave !== undefined && !object.isSave &&
        object.percentLoader !== undefined && object.percentLoader !== 100 &&
        object.hasError !== undefined && !object.hasError
    },
    saveFile (object) {
      const formData = new window.FormData()
      formData.append('file', object.file)

      axios.post('/api/portfolio_items/files', formData, {
        onUploadProgress: function (progressEvent) {
          object.percentLoader = Math.round((progressEvent.loaded * 100) / progressEvent.total)
        }
      })
        .then(function (response) {
          object.id = response.data.id
          object.percentLoader = 100
          object.isSave = true
        })
        .catch(function () {
          object.hasError = true
          object.isServerError = true
        })
    },
    downloadAgain (object) {
      object.hasError = false
      object.isServerError = false
      this.saveFile(object)
    },
    deleteFile (fileId, index) {
      if (window.confirm('Вы уверены?')) {
        var vm = this

        axios.delete('/api/portfolio_items/' + fileId, {
          headers: { 'Access-Token': this.accessToken }
        })
          .then(function (response) {
            vm.internalValue[index].isDeleted = true
            vm.internalValue[index].isSave = undefined
            vm.setInternalValue(vm.internalValue[index], index)
          })
      }
    },
    restoreFile (fileId, index) {
      var vm = this

      axios.delete('/api/portfolio_items/restore/' + fileId, {
        headers: { 'Access-Token': this.accessToken }
      })
        .then(function (response) {
          vm.internalValue[index].isDeleted = false
          vm.setInternalValue(vm.internalValue[index], index)
        })
    },
    setInternalValue (value, index) {
      this.$set(this.internalValue, index, value)
    },
    pushInternalValue (file, fileUrl) {
      this.internalValue.push({
        file: file,
        preview_url: fileUrl,
        isSave: false,
        isShowCloseIcon: false,
        description: '',
        percentLoader: 0,
        hasError: false,
        errorMessage: '',
        isIncorrectFormat: false,
        isServerError: false,
        isDeleted: false
      })

      return this.internalValue[this.internalValue.length - 1]
    },
    checkIfAllowDelete (object) {
      return object.isShowCloseIcon && !object.hasError && this.countActiveItems > 1 && (object.isSave === undefined || object.isSave)
    },
    resizeImage (img, file) {
      var MAX_WIDTH = 118
      var MAX_HEIGHT = 119

      var width = img.width
      var height = img.height
      var sx = 0
      var sy = 0

      if (width > height) {
        if (width / height > 1.5) sx = -MAX_WIDTH / (width / height) + 20 * (width / height)
        width = MAX_WIDTH * width / height
        height = MAX_HEIGHT
      } else {
        height = MAX_HEIGHT * height / width
        width = MAX_WIDTH
      }

      var canvas = document.createElement('canvas')
      canvas.width = MAX_WIDTH
      canvas.height = MAX_HEIGHT

      var ctx = canvas.getContext('2d')
      ctx.drawImage(img, sx, sy, width, height)
      return canvas.toDataURL(file.type)
    }
  },
  computed: {
    countActiveItems () {
      return this.internalValue.filter(value => !value.isDeleted).length
    }
  }
}
</script>
