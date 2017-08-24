<template>
  <custom-select
    ref="component"
    v-bind="$attrs"
    v-bind:value="internalValue"
    @input="updateValue"
    @select="updateSelect"
    >
    <template slot="clear" scope="props">
      <div
        class="multiselect__clear"
        v-if="showResetSlot"
        @mousedown.prevent.stop="clearAll(props.search)"
        >
        x
      </div>
    </template>
  </custom-select>
</template>
<script>
import CustomSelect from 'components/custom-select'
export default {
  props: {
    value: {
      default: [],
    },
    showReset: {
      default: false,
      type: Boolean
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
    clearAll () {
      this.internalValue = []
    }
  },
  watch: {
    value () {
      this.internalValue = this.value
    },
    internalValue () {
      this.$emit('input', this.internalValue)
    },
  },
  computed: {
    showResetSlot () {
      return (this.showReset && (
          (Array.isArray(this.value) && this.value.length)
        )
      )
    }
  },
  components: {
    CustomSelect
  }
}
</script>
