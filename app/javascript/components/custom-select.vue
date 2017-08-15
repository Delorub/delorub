<script>
import Multiselect from 'vue-multiselect'
function deepClone (obj) {
  if (Array.isArray(obj)) {
    return obj.map(deepClone)
  } else if (obj && typeof obj === 'object') {
    var cloned = {}
    var keys = Object.keys(obj)
    for (var i = 0, l = keys.length; i < l; i++) {
      var key = keys[i]
      cloned[key] = deepClone(obj[key])
    }
    return cloned
  } else {
    return obj
  }
}
export default {
  mixins: [Multiselect],
  data () {
    return {
      internalValue: this.getInternalValue(this.value)
    }
  },
  props: {
    placeholder: {
      type: String,
      default: 'Выберите...'
    },
    tagPlaceholder: {
      type: String,
      default: 'Нажмите enter для создания'
    },
    selectLabel: {
      type: String,
      default: 'Нажмите enter чтобы выбрать'
    },
    selectedLabel: {
      type: String,
      default: 'Выбрано'
    },
    deselectLabel: {
      type: String,
      default: 'Нажмите enter для отмены'
    },
    return: {
      type: String,
      default: ''
    }
  },

  methods: {
    /**
     * Converts the external value to the internal value
     * @returns {Array} returns the internal value
     */
    getInternalValue (value) {
      if (value === null || value === undefined) {
        return []
      } else {
        if (this.return) {
          value = this.options.find((option) => String(option[this.return]) === String(value)) || ''
        }
        return this.multiple
          ? deepClone(value)
          : deepClone([value])
      }
    },
    /**
     * Add the given option to the list of selected options
     * or sets the option as the selected option.
     * If option is already selected -> remove it from the results.
     *
     * @param  {Object||String||Integer} option to select/deselect
     * @param  {Boolean} block removing
     */
    select (option, key) {
      /* istanbul ignore else */
      if (this.blockKeys.indexOf(key) !== -1 || this.disabled || option.$isLabel) return
      /* istanbul ignore else */
      if (this.max && this.multiple && this.internalValue.length === this.max) return
      if (option.isTag) {
        this.$emit('tag', option.label, this.id)
        this.search = ''
        if (this.closeOnSelect && !this.multiple) this.deactivate()
      } else {
        const isSelected = this.isSelected(option)
        if (isSelected) {
          if (key !== 'Tab') this.removeElement(option)
          return
        } else if (this.multiple) {
          this.internalValue.push(option)
        } else {
          this.internalValue = [option]
        }
        this.$emit('select', deepClone(option), this.id)
        let value = this.getValue()
        value = this.return ? value[this.return] : value
        this.$emit('input', value, this.id)

        /* istanbul ignore else */
        if (this.clearOnSelect) this.search = ''
      }
      /* istanbul ignore else */
      if (this.closeOnSelect) this.deactivate()
    }
  }
}
</script>
