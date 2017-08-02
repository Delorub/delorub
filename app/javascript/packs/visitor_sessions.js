import $ from 'jquery'
import Cookies from 'js-cookie'

function getVisitorLinkExpireTime () {
  return new Date(new Date().getTime() + 0.5 * 60 * 1000)
}

function reachGoal (goalId) {
  if (goalId !== undefined && window.yaCounter45408213 !== undefined) {
    window.yaCounter45408213.reachGoal(goalId)
  }
}

$(document).ready(function () {
  $('a').on('click', function (e) {
    var linkId = $(this).data('identity')
    var linkTitle = $(this).text()
    reachGoal(linkId)
    Cookies.set('session_last_link_id', linkId, { expires: getVisitorLinkExpireTime() })
    Cookies.set('session_last_link_title', linkTitle, { expires: getVisitorLinkExpireTime() })
  })

  $('form').on('submit', function (e) {
    var formId = $('input[name=form_identity]', this).val()
    reachGoal(formId)
  })

  $('a[href="#"]').on('click', function (e) {
    e.preventDefault()
    window.location = '/coming-soon'
  })
})
