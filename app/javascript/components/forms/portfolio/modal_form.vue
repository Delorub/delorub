<template lang="pug">
  #openAlbum.modalAlbum(style="display:block; pointer-events: auto;" v-if="portfolio !== null" @click.self="closeModal()")
    div
      a.close-modal(href="#" title="Закрыть" @click.prevent="closeModal()")
      .album-modal-portfolio
        .album-modal-slider
          carousel(ref="carousel" :perPage="1" :navigationEnabled="false" :paginationEnabled="false" @pageChange="onPageChange")
            template(v-for="item in internalValue")
              slide(style="max-width:750px; max-height: 480px; display: flex; justify-content: center; align-items: center;")
                img(:src="item.thumb_url" style="width:auto; height: auto;")
          .album-modal-slider__header
            h2 {{ portfolio.name }}
          .album-modal-slider__wrap(style="top: calc(30% - 15px)")
            a.modal-arrow-left(href="#" v-show="currentPage > 0" @click.prevent="prevPage")
            a.modal-arrow-right(href="#" v-show="currentPage < (internalValue.length - 1)" @click.prevent="nextPage")
          .p-3
            .album-modal-text.dr-text-15(v-if="currentItem().description !== ''") {{ currentItem().description }}
          .album-modal-photo-container
            .d-flex.flex-wrap
              template(v-for="(item, index) in internalValue")
                .album-modal-items(:class="currentPage === index ? 'checked' : ''" @click.prevent="currentPage = index")
                  img(:src="item.small_url")
          hr
          .album-modal-description
            h2 Описание альбома
            .dr-text-15.my-3 {{ portfolio.description === '' ? 'Описание альбома отсутсвует' : portfolio.description }}
            a.dr-btn-danger(v-if="canEdit" :href="editPath(portfolio.id)")  Редактировать альбом
</template>
<script>
  export default {
    props: ['portfolio', 'canEdit'],
    data: function () {
      return {
        currentPage: 0,
        internalValue: this.portfolio.portfolio_items
      }
    },
    mounted () {
      this.currentPage = this.$refs['carousel'].currentPage
      document.querySelector('body').style.overflow = 'hidden'
    },
    methods: {
      closeModal () {
        document.querySelector('body').style.overflow = 'auto'
        this.$emit('modal-portfolio', null)
      },
      editPath (portfolioId) {
        return '/my/portfolios/' + portfolioId + '/edit'
      },
      currentItem () {
        return this.internalValue[this.currentPage]
      },
      nextPage () {
        this.currentPage = this.currentPage >= (this.internalValue.length - 1) ? this.currentPage : this.currentPage + 1
      },
      prevPage () {
        this.currentPage = this.currentPage > 0 ? this.currentPage - 1 : this.currentPage
      },
      onPageChange (page) {
        if (this.currentPage !== page) {
          this.currentPage = page
        }
      }
    },
    computed: {
      isShowModal () {
        return this.internalValue.length > 0 ? 'display:block; pointer-events: auto;' : 'display:none'
      }
    },
    watch: {
      currentPage () {
        if (this.currentPage !== this.$refs.carousel.currentPage) {
          this.$refs.carousel.goToPage(this.currentPage)
        }
      }
    }
  }
</script>
