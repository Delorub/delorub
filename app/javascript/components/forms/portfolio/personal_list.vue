<template lang="pug">
  .row
    template(v-for="(portfolio, index) in internalValue")
      .col-xl-4.col-md-6
        template(v-if="portfolio.isDeleted")
          .performer-description-portfolio__item.performer-description-portfolio__remove-item
            span
              | Удалено.&nbsp
              a.link-default(href="#" @click.prevent="restoreFile(portfolio.id, index)") Восстановить
        template(v-else)
          .performer-description-portfolio__item
            img(:src="portfolio.preview_url")
            .album-image-links.album-image-links--profile
              a.album-image-edit(:href="editPath(portfolio.id)")
                .album-tooltip-edit Редактировать
              span &nbsp|&nbsp
              a.album-image-close(href="#" @click.prevent="deletePortfolio(portfolio.id, index)")
                .album-tooltip-close Удалить
            .performer-description-portfolio__item-description
              .performer-description-portfolio__item-description__text
                p {{ truncateString(portfolio.description, 30)}}
              .performer-description-portfolio__item-description__header
                p {{ truncateString(portfolio.name, 20) }}
                span.performer-description-portfolio__item-description__count
                  | {{ portfolio.count_items }}
    .col-xl-4.col-md-6
      .performer-description-portfolio__item
        a.performer-description-portfolio__add-album(href="/my/portfolios/new") +
</template>
<script>
import axios from 'axios'

export default {
  props: ['value', 'userToken'],
  data: function () {
    return {
      internalValue: [],
      accessToken: this.userToken
    }
  },
  mounted () {
    this.value.every((e) => this.internalValue.push(Object.assign(e, { isDeleted: false })))
  },
  methods: {
    truncateString (string, num) {
      if (num > string.length) {
        return string
      } else {
        return string.substring(0, num) + '...'
      }
    },
    editPath (portfolioId) {
      return '/my/portfolios/' + portfolioId + '/edit'
    },
    deletePortfolio (portfolioId, index) {
      if (window.confirm('Вы уверены?')) {
        var vm = this

        axios.delete('/api/portfolios/' + portfolioId, {
          headers: { 'Access-Token': this.accessToken }
        }).then(function (response) {
          vm.internalValue[index].isDeleted = true
          vm.setInternalValue(vm.internalValue[index], index)
        })
      }
    },
    restoreFile (portfolioId, index) {
      var vm = this

      axios.delete('/api/portfolios/restore/' + portfolioId, {
        headers: { 'Access-Token': this.accessToken }
      }).then(function (response) {
        vm.internalValue[index].isDeleted = false
        vm.setInternalValue(vm.internalValue[index], index)
      })
    },
    setInternalValue (value, index) {
      this.$set(this.internalValue, index, value)
    }
  }
}
</script>
