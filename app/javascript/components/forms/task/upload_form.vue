<template lang="pug">
  div(:class="formClass")
    span(class="task-upload-form-error-message") {{ lastErrorMessage }}
    slot(name="file" v-for="file in internalValue" :file="file")
    div(ref="dropzone" class="dropzone")
      div.dz-message
        img.dz-plus(src="/images/design/dz-plus.svg" alt="")
        span.upload-span Перетащите сюда файлы
</template>
<script>
  import Dropzone from 'lib/dropzone'

  export default {
    props: [
      'url', 'value'
    ],
    data: function () {
      return {
        internalValue: this.value,
        lastErrorMessage: null
      }
    },
    mounted () {
      this.dropzone = new Dropzone(this.$refs.dropzone, {
        url: this.url,
        maxFiles: 4,
        acceptedFiles: 'image/*,application/pdf,.doc,.xls,.xlsx,.csv,.rtf,.txt,.zip,.bmp,.ttf',
        maxFilesize: 7,
        autoDiscover: false,
        addRemoveLinks: true
      })

      this.populateDropzone()

      this.dropzone.on('drop', (file) => { this.$emit('change') })
      this.dropzone.on('addedfile', (file) => { this.$emit('change') })

      this.dropzone.on('success', this.addFile)
      this.dropzone.on('removedfile', this.removeFile)
      this.dropzone.on('error', this.errorFile)
    },
    methods: {
      addFile (file, response) {
        file.id = response.id

        this.internalValue.push({
          id: response.id
        })
      },
      removeFile (file) {
        let file_index

        this.internalValue.forEach((e, index) => {
          if (e.id == file.id) {
            file_index = index
          }
        })

        if (file_index !== undefined) {
          this.internalValue.splice(file_index, 1)
        }
      },
      errorFile (file, message, xhr) {
        this.dropzone.removeFile(file)

        if (xhr !== undefined) {
          this.lastErrorMessage = 'Ошибка сервера. Пожалуйста, попробуйте загрузить файл позже'
        } else {
          this.lastErrorMessage = message
        }
      },
      populateDropzone () {
        this.value.forEach((e) => {
          let mockFile = {
            name: 'thumb.jpg',
            size: 12345,
            id: e.id,
            status: Dropzone.ADDED,
            accepted: true
          }

          this.dropzone.emit('addedfile', mockFile)
          if(e.file.upload_preview.url !== null) {
            this.dropzone.emit('thumbnail', mockFile, e.file.upload_preview.url)
          }

          this.dropzone.emit('complete', mockFile)
          this.dropzone.files.push(mockFile)
        })
      }
    },
    computed: {
      formClass () {
        let className = 'task-upload-form'

        if (this.lastErrorMessage !== null) {
          className += ' task-upload-form-error'
        }

        return className
      }
    },
    watch: {
      internalValue () {
        this.$emit('change')
        this.$emit('input', this.internalValue)
      }
    }
  }
</script>

<style lang="scss">
  @import '../../../stylesheets/_vars.sass';
  @import 'dropzone/dist/dropzone.css';
</style>
