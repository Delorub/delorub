<template lang="pug">
  div
    selectbox(
      v-model="internalValue"
      :searchable="true"
      placeholder="Выберите город"
      :options="cities"
      track-by="id"
      label="label"
      @search-change='search'
      :clear-on-select="false"
    )
    slot(name="input" :id="inputValue")
</template>

<script>
  import axios from 'axios'

  export default {
    props: ['value'],
    data: function () {
      return {
        internalValue: this.value,
        cities: []
      }
    },
    methods: {
      search (query) {
        axios.post('/api/cities', {
          query: query
        }).then(response => {
          this.cities = response.data.map((e) => (
            { id: e.id, label: e.full_name }
          ))
        })
      }
    },
    computed: {
      inputValue () {
        if (!this.internalValue) return
        return this.internalValue.id
      }
    }
  }
</script>
