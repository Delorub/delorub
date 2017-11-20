<template lang="pug">
  div
    template(v-if="this.profilesList.length === 0")
      .dr-block-style.dr-block-style--card
        p В данной категории пока нет ни одного исполнителя
          template(v-if="policyCreate !== undefined")
            p
              b Станьте первым!
            a.dr-btn-danger(href="/profiles/new") Стать исполнителем
    template(v-else)
      .dr-block-style.dr-block-style--sort-padding
        .task-sort
          .row
            .col-xl-3.col-lg-6
              .checkbox
                label
                  input(type="checkbox" :checked="checkboxIsChecked")
                  span.checkbox-custom(@click.present="executeQuery")
                  span(@click.present="executeQuery")
                    | Новые&nbsp;исполнители
      template(v-for="(profile, index) in profilesList")
        .dr-block-style.dr-block-style--no-padding.dr-block-style--margin-top
          .master-card-container
            .row.mt-2
              .col-lg-2
                .master-card-person
                  .master-card-person__image
                    img(alt="Аватар" :src="profile.photo_url")
                    .performer-profile-main__status(v-if="profile.is_online")
                      span.status-online Online
                  .master-card-person__mark
              .col
                .master-card-description
                  .row.align-items-baseline
                    .col-md.col-12
                      p.master-card-description__header.md-center
                        a.link-default(:href="profilePath(profile.id)") {{ profile.name }}
                    .col-md-auto.col-12
                      b {{ profile.formatted_price }}
                  p.master-card-description__text {{ truncateString(profile.about, 180) }}
          hr
          .master-card-contacts
            a.link-default(href="#" role="button" @click.prevent="toggleIsShow(profile)" v-show="!profile.isShow") Показать контакты
            .row(v-show="profile.isShow")
              .col-md-4.col-12(v-if="profile.phone !== null && profile.phone !==''")
                img.mr-2(alt="phone" src="/images/icons/phone.svg")
                span {{ profile.phone }}
              .col-md-8.col-12.mt-2.mt-md-0(v-if="profile.email !== null && profile.email !==''")
                img.mr-2(alt="email" src="/images/icons/mail.svg")
                span {{ profile.email }}
          hr
          template(v-if="profile.portfolios.length > 0")
            .master-card-portfolio
              .master-card-portfolio__header
                h2
                  | Портфолио
              .master-card-portfolio__content
                .row
                  template(v-for="(portfolio, index) in profile.portfolios.slice(0, 3)")
                    .col-xl-3.col-md-4.col-sm-6
                      .master-card-portfolio__item
                        a(href="#" @click.prevent="modalPortfolio = portfolio")
                          img(:src="portfolio.small_url")
                        .master-card-portfolio__item-description
                          .master-card-portfolio__item-description__header
                            p {{ truncateString(portfolio.name, 20) }}
                            span.master-card-portfolio__item-description__count {{ portfolio.count_items }}
                  template(v-if="profile.portfolios.length > 3")
                    .col-xl-3.col-md-4.col-sm-6
                      .master-card-portfolio__item
                        .master-card-portfolio__show-more
                          a.link-default(:href="profilePath(profile.id)") Показать еще
            hr
      custom-pagination(
        :current-page="currentPage"
        :count-pages="countPages"
      )
      template(v-if="modalPortfolio !== null")
        portfolio-modal-form(:portfolio="modalPortfolio" @modal-portfolio="modalPortfolio = $event" :can-edit="false")
</template>
<script>
  import axios from 'axios'

  export default {
    props: ['profiles', 'policyCreate', 'paramsValue', 'countPages'],
    data: function () {
      return {
        profilesList: [],
        checkboxIsChecked: true,
        currentPage: this.paramsValue.page,
        modalPortfolio: null
      }
    },
    mounted: function () {
      this.profiles.every((e) => this.profilesList.push(Object.assign(e, { isShow: false })))
    },
    methods: {
      executeQuery () {
        axios.post('/api/profiles/order', {
          query: this.queryParams
        }).then(response => {
          this.profilesList = []
          response.data.every((e) => this.profilesList.push(Object.assign(e, { isShow: false })))
          this.oppositeCheckedValue()
        })
      },
      profilePath (profileId) {
        return '/profile/' + profileId
      },
      truncateString (string, num) {
        if (num > string.length) {
          return string
        } else {
          return string.substring(0, num) + '...'
        }
      },
      toggleIsShow (profile) {
        profile.isShow = !profile.isShow
      },
      oppositeCheckedValue () {
        this.checkboxIsChecked = !this.checkboxIsChecked
      }
    },
    computed: {
      queryParams () {
        return Object.assign(this.paramsValue, { direction_created: this.directionCreatedValue })
      },
      directionCreatedValue () {
        return this.checkboxIsChecked ? '1' : ''
      }
    },
    watch: {
      modalPortfolio (value) {
        this.$emit('portfolio', value)
      }
    }
  }
</script>
