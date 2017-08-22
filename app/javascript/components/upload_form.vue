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
      maxFilesize: 0,
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
  @import '../stylesheets/_vars.sass';
  @import "dropzone/dist/dropzone.css";

  .dropzone {
    color: #9b9b9b;
    text-align: center;
    padding: 20px;
    display: block;
    font-size: 0.8rem;
    font-weight: bold;
    border: 2px dashed;
    margin-bottom: 25px;
    min-height: 0px;

    .dz-message {
      margin: 0;
    }

    i.upload-icon {
      display: none;
      font-size: 1.2rem;
      color: #8bc4e3;
    }
    &:hover {
      border: dashed 2px #519dc7;
      span.upload-span {
        display: none;
      }
      i.upload-icon {
        display: block;
      }
    }
    &:active {
      background-color: #fcf6f6;
      //border: dashed 2px $blueColor;
      span.upload-span {
        display: none;
      }
      i.upload-icon {
        display: block;
      }
    }
  }

  .dropzone.dz-drag-hover {
    background-color: #fcf6f6;
    border: dashed 2px #519dc7;
    span.upload-span {
      display: none;
    }
    i.upload-icon {
      display: block;
    }
  }

  .dropzone.dz-started {
    border: dashed 3px #e8f5fd;
  }

  </style>
