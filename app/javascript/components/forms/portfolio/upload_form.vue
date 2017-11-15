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
            template(v-if="file.incorrectFormat")
              .album-image-unacceptable
            template(v-else)
              img(:src="file.preview_url" style="width:118px; height:119px" v-bind:class="file.hasError ? 'album-image-mask' : ''")
              .progress(v-if="hasProgressBar(file)")
                .progress-bar(aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" :style="progressBarWidth(file)")
          template(v-if="!file.hasError && !file.isDeleted")
            .form-group.album-image-textarea
              textarea.form-control(placeholder=("Описание фотографии") rows="5" v-model="file.description")
          template(v-else)
            .album-image-error
              p {{ file.errorMessage }}
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
      reader.onload = (function (file) {
        return function (e) {
          var thisInternalValue = vm.pushInternalValue(e)

          vm.validateFile(file, thisInternalValue)
          if (!thisInternalValue.hasError) vm.addFile(file, thisInternalValue)
        }
      })(file)
      reader.readAsDataURL(file)
    },
    addFile (file, internalValue) {
      const formData = new window.FormData()
      formData.append('file', file)

      axios.post('/api/portfolio_items/files', formData, {
        onUploadProgress: function (progressEvent) {
          internalValue.percentLoader = Math.round((progressEvent.loaded * 100) / progressEvent.total)
        }
      }).then(function (response) {
        internalValue.id = response.data.id
        internalValue.percentLoader = 100
        internalValue.isSave = true
      }).catch(function (error) {
        console.log(error)
      })
    },
    progressBarWidth (file) {
      return 'width:' + file.percentLoader + '%'
    },
    validateFile (file, object) {
      if (this.fileSize(file) > 10) {
        this.fileSetError(object, 'Файл слишком большой (максимальный размер файла - 10 Мб)')
      } else if (!file.type.match(/.(bmp|jpeg|png|jpg)$/i)) {
        this.fileSetError(object, 'Недопустимый формат файла, поддерживаемые форматы: jpg, png, bmp', true)
      }
    },
    fileSize (file) {
      return file.size / (1024 * 1024)
    },
    fileSetError (object, message, incorrectFormat = false) {
      object.hasError = true
      object.errorMessage = message
      object.incorrectFormat = incorrectFormat
    },
    hasProgressBar (file) {
      return file.isSave !== undefined && !file.isSave &&
        file.percentLoader !== undefined && file.percentLoader !== 100 &&
        file.hasError !== undefined && !file.hasError
    },
    deleteFile (fileId, index) {
      var vm = this

      axios.delete('/api/portfolio_items/' + fileId, {
        headers: { 'Access-Token': this.accessToken }
      }).then(function (response) {
        vm.internalValue[index].isDeleted = true
        vm.setInternalValue(vm.internalValue[index], index)
      })
    },
    restoreFile (fileId, index) {
      var vm = this

      axios.delete('/api/portfolio_items/restore/' + fileId, {
        headers: { 'Access-Token': this.accessToken }
      }).then(function (response) {
        vm.internalValue[index].isDeleted = false
        vm.setInternalValue(vm.internalValue[index], index)
      })
    },
    setInternalValue (value, index) {
      this.$set(this.internalValue, index, value)
    },
    pushInternalValue (file) {
      this.internalValue.push({
        preview_url: file.target.result,
        isSave: false,
        isShowCloseIcon: false,
        description: '',
        percentLoader: 0,
        hasError: false,
        errorMessage: '',
        incorrectFormat: false,
        isDeleted: false
      })

      return this.internalValue[this.internalValue.length - 1]
    },
    checkIfAllowDelete (file) {
      return file.isShowCloseIcon && !file.hasError && this.countActiveItems > 1
    }
  },
  computed: {
    countActiveItems () {
      return this.internalValue.filter(value => !value.isDeleted).length
    }
  }
}
</script>
