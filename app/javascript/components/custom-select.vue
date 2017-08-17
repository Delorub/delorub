<script>
import Multiselect from 'vue-multiselect'
export default {
  mixins: [Multiselect],
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
  }
}
</script>
