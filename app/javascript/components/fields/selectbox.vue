<template lang="pug">
  div
    vue-multiselect(
      ref="component"
      v-bind="attrs"
      v-bind:value="internalValue"
      @input="updateValue"
      @select="updateSelect"
      @search-change="updateSearchChange"
      @open="updateOpen"
    )
      template(slot="clear" scope="props")
        div(
          class="multiselect__clear"
          v-if="showResetSlot"
          @mousedown.prevent.stop="clearAll(props.search)"
        ) x
    slot(name="input" :value="internalValue")
</template>
<script>
  import VueMultiselect from 'vue-multiselect'

  export default {
    props: {
      value: {
        default: []
      },
      showReset: {
        default: false,
        type: Boolean
      },
      labels: {
        default: undefined,
        type: Array
      }
    },
    data: function () {
      return {
        internalValue: this.value
      }
    },
    methods: {
      updateValue (value) {
        this.internalValue = value
      },
      updateSelect (value) {
        this.$emit('select', value)
      },
      updateOpen (value) {
        this.$emit('open', value)
      },
      updateSearchChange (value) {
        this.$emit('search-change', value)
      },
      clearAll () {
        this.internalValue = []
      },
      labelMethod (id) {
        var result
        this.labels.every((e) => {
          if (String(e.value) === String(id)) {
            result = e
            return false
          }
          return true
        })
        return result ? result.label : id
      }
    },
    watch: {
      value () {
        this.internalValue = this.value
      },
      internalValue () {
        this.$emit('input', this.internalValue)
      }
    },
    computed: {
      attrs: function () {
        let attributes = {
          'searchable': false,
          'allow-empty': false
        }

        if (this.labels !== undefined) {
          attributes = Object.assign(attributes, {
            'custom-label': this.labelMethod
          })
        }

        return Object.assign(attributes, this.$attrs)
      },
      showResetSlot () {
        return (this.showReset && (
          (Array.isArray(this.value) && this.value.length)
        ))
      }
    },
    components: {
      VueMultiselect
    }
  }
</script>
