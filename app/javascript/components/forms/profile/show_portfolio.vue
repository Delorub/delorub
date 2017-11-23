<template lang="pug">
  .dr-block-style.dr-block-style--profile(v-if="internalValue.length > 0")
    .performer-description-category
      .performer-description-category__header
        h2 Портфолио
      .master-card-portfolio__content
        .row
          template(v-for="(portfolio, index) in portfolios")
            .col-xl-3.col-md-4.col-sm-6
              .master-card-portfolio__item
                a(href="#" @click.prevent="modalPortfolio = portfolio")
                  img(:src="portfolio.small_url")
                .master-card-portfolio__item-description
                  .master-card-portfolio__item-description__header
                    p {{ truncateString(portfolio.name, 20) }}
                    span.master-card-portfolio__item-description__count {{ portfolio.count_items }}
    template(v-if="modalPortfolio !== null")
      portfolio-modal-form(:portfolio="modalPortfolio" @modal-portfolio="modalPortfolio = $event" :can-edit="false")
</template>
<script>
export default {
  props: ['portfolios'],
  data: function () {
    return {
      internalValue: this.portfolios,
      modalPortfolio: null
    }
  },
  methods: {
    truncateString (string, num) {
      if (num > string.length) {
        return string
      } else {
        return string.substring(0, num) + '...'
      }
    }
  },
  watch: {
    modalPortfolio (value) {
      this.$emit('portfolio', value)
    }
  }
}
</script>
