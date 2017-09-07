<template>
  <div ref="dropzone">
    <slot></slot>
  </div>
</template>
<script>
import Dropzone from 'dropzone'
Dropzone.autoDiscover = false

export default {
  props: [
    'url'
  ],
  mounted () {
    this.dropzone = new Dropzone(this.$refs.dropzone, {
      url: this.url,
      maxFiles: 4,
      acceptedFiles: 'image/*',
      maxFilesize: 7,
      autoDiscover: false,
      addRemoveLinks: true,
      dictRemoveFile: 'Удалить'
    })

    this.dropzone.on('drop', (file) => { this.$emit('change') })
    this.dropzone.on('addedfile', (file) => { this.$emit('change') })
  }
}
</script>

<style lang="scss">
  @import '../../stylesheets/_vars.sass';
  @import 'dropzone/dist/dropzone.css';
</style>
