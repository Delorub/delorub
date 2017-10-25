<template lang="pug">
  nav(class="pagination")
    template(v-if="pages > 1")
      template(v-if="pages < 6")
        page(:page="page - 1" v-if="page > 1" prev="true")
        page(v-for="n in pages" :page="n" :active="page === n")
        page(:page="page + 1" v-if="page < pages" next="true")

      template(v-else)
        page(:page="page - 1" v-if="page > 1" prev="true")
        page(:page="1" v-if="page > 2")

        page(:page="2" v-if="page === 4")
        page(v-else-if="page > 4" :ellipsis="true")

        page(:page="page - 1" v-if="page > 1")
        page(:page="page" active="true")
        page(:page="page + 1" v-if="page < pages")

        page(:page="page + 2" v-if="pages - page === 3")
        page(v-else-if="pages - page > 3" :ellipsis="true")

        page(:page="pages" v-if="pages - page > 1")

        page(:page="page + 1" next="true" v-if="page < pages")
</template>
<script>
  import page from './pagination/page.vue'
  export default {
    props: ['current-page', 'count-pages'],
    computed: {
      page () {
        return Number(this.currentPage === undefined ? 1 : this.currentPage)
      },
      pages () {
        return Number(this.countPages)
      }
    },
    components: { page }
  }
</script>
