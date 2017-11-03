<template lang="pug">
  div
    template(v-if="this.tasksList.length === 0")
      .dr-block-style.dr-block-style--card
        p В данной категории пока не создано ни одного задания
        p
          b Станьте первым!
        a.dr-btn-danger(href="/tasks/new") Создать задание
    template(v-else)
      .dr-block-style.dr-block-style--sort-padding
        .task-sort
          .row
            .col-md-6.col-xl-auto
              span
                b
                  | Сортировать по:
            .col-xl-3.col-lg-6
              a(href="#" class="task-sort__link" @click.prevent="executeQuery()")
                | Дате размещения
                |
                i.fa(:class="classDirectionCreatedAt")
      template(v-for="task in tasksList")
        .dr-block-style.dr-block-style--task-card
          .row
            .col
              .row
                .col-sm.col-12
                  .task-card-description
                    p.task-card-description__header
                      a(:href="taskPath(task.id)") {{ truncateString(task.title, 60) }}
                div
                  .task-card-refinement
                    p.task-card-refinement__price
                      | {{ isBlank(task.price_exact) ? 'Не указана' : `${task.price_exact} руб.` }}
                    p.task-card-refinement__date
                      | Размещено&nbsp;
                      span {{ task.date_created_at }}
                    template(v-if="!isBlank(task.date_type)")
                      template(v-if="timeExpiresBeforeTomorrow(task.date_type, 'end_at', task.date_actual) || timeExpiresBeforeTomorrow(task.date_type, 'interval', task.date_interval_to)")
                        p.task-card-refinement__time.task-card-refinement__time--quickly
                          i.fa.fa-clock-o(aria-hidden="true")
                          timer-countdown(:expire_date = "expireDate(task)")
                      template(v-else)
                        p.task-card-refinement__time
                          template(v-if="checkDateType(task.date_type, 'start_at', task.date_actual)")
                            | C
                            |
                          template(v-else-if="checkDateType(task.date_type, 'end_at', task.date_actual)")
                            | До
                            |
                          | {{ task.human_date }}
              .row
                .col
                  .task-card-description
                    p.task-card-description__adress
                      img(src="/images/icons/place_red.svg" alt="place")
                      | {{ isBlank(task.place_address) ? 'Адрес не указан' : task.place_address }}
      custom-pagination(
        :current-page="currentPage"
        :count-pages="countPages"
      )
</template>
<script>
import axios from 'axios'
import timerCountdown from '../../timer_countdown.vue'

export default {
  props: ['tasks', 'paramsValue', 'countPages'],
  data: function () {
    return {
      tasksList: this.tasks,
      currentPage: this.paramsValue.page,
      directionCreatedAt: 'desc'
    }
  },
  methods: {
    executeQuery () {
      this.directionCreatedAt = this.inverseDirectionCreateAt
      axios.post('/api/tasks/order', {
        query: this.queryParams
      }).then(response => {
        this.tasksList = response.data
      })
    },
    taskPath (taskId) {
      return '/task/' + taskId
    },
    isBlank (value) {
      return value === null || value === ''
    },
    timeExpiresBeforeTomorrow (dateType, type, time) {
      return this.checkDateType(dateType, type, time) && (new Date(time) <= this.tomorrowTime)
    },
    expireDate (task) {
      return task.date_type === 'end_at' ? new Date(task.date_actual) : new Date(task.date_interval_to)
    },
    checkDateType (dateType, type, time) {
      return !this.isBlank(time) && dateType === type
    },
    truncateString (string, num) {
      if (num > string.length) {
        return string
      } else {
        return string.substring(0, num) + '...'
      }
    }
  },
  computed: {
    queryParams () {
      return Object.assign(this.paramsValue, { direction_created: this.directionCreatedAt })
    },
    inverseDirectionCreateAt () {
      return this.directionCreatedAt === 'desc' ? 'asc' : 'desc'
    },
    tomorrowTime () {
      var date = new Date()
      date.setDate(date.getDate() + 1)
      return date
    },
    classDirectionCreatedAt () {
      return 'fa-caret-' + (this.directionCreatedAt === 'desc' ? 'down' : 'up')
    }
  },
  components: { timerCountdown }
}
</script>
