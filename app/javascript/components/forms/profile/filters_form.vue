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
      template(v-for="profile in profilesList")
        .dr-block-style.dr-block-style--card
          .row
            .col-lg-2
              .master-card-person
                .master-card-person__image(:class="profile.is_online ? 'master-card-person__image--online' : ''")
                  img(alt="" :src="profile.photo_url")
              .master-card-person__mark
            .col
              .master-card-description
                .row.justify-content-space-between
                  .col-sm.col-12
                    p.master-card-description__header
                      a(:href="profilePath(profile.id)")
                        | {{ profile.name }}
                  div.sm-center
                    span.master-card-description__price
                      | {{ profile.formatted_price }}
                p.master-card-description__text
                  | {{ truncateString(profile.about, 180) }}
                hr.toggle-hr-sm/
                .performer-profile-main__contacts
                  a.link-default(href="#" role="button" @click.prevent="toggleShowContacts(profile.id)" v-show="!isShowContacts(profile.id)") Показать контакты
                  div(v-show="isShowContacts(profile.id)")
                    .contacts-container
                      template(v-if="profile.phone !== null && profile.phone !==''")
                        div
                          span
                            img(src="/images/icons/phone.svg" alt="phone")
                            | {{ profile.phone }}
                      template(v-if="profile.email !== null && profile.email !==''")
                        div
                          span
                            img(src="/images/icons/mail.svg" alt="email")
                            | {{ profile.email }}
      custom-pagination(
        :current-page="currentPage"
        :count-pages="countPages"
      )
</template>
<script>
  import axios from 'axios'

  export default {
    props: ['profiles', 'policyCreate', 'paramsValue', 'countPages'],
    data: function () {
      return {
        profilesList: this.profiles,
        checkboxIsChecked: true,
        currentPage: this.paramsValue.page,
        showContactsArray: []
      }
    },
    mounted: function () {
      this.fillContactsArray()
    },
    methods: {
      executeQuery () {
        axios.post('/api/profiles/order', {
          query: this.queryParams
        }).then(response => {
          this.profilesList = response.data
          this.fillContactsArray()
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
      toggleShowContacts (profileId) {
        this.showContactsArray = this.showContactsArray.map((e) => (
          { id: e.id, isShow: ((e.id === profileId) ? !e.isShow : e.isShow) }
        ))
      },
      isShowContacts (profileId) {
        var result = false
        this.showContactsArray.every((e) => {
          if (e.id === profileId) {
            result = e.isShow
            return false
          }
          return true
        })
        return result
      },
      oppositeCheckedValue () {
        this.checkboxIsChecked = !this.checkboxIsChecked
      },
      fillContactsArray () {
        this.showContactsArray = this.profilesList.map((e) => (
          { id: e.id, isShow: false }
        ))
      }
    },
    computed: {
      queryParams () {
        return Object.assign(this.paramsValue, { direction_created: this.directionCreatedValue })
      },
      directionCreatedValue () {
        return this.checkboxIsChecked ? '1' : ''
      }
    }
  }
</script>
