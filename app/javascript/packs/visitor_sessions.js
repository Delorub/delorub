import $ from 'jquery'
import Cookies from 'js-cookie'

function getVisitorLinkExpireTime () {
  return new Date(new Date().getTime() + 0.5 * 60 * 1000)
}

$(document).ready(function () {
  $('a').on('click', function (e) {
    var linkId = $(this).data('identity')
    var linkTitle = $(this).text()
    if (linkId !== undefined && window.yaCounter45408213 !== undefined) {
      window.yaCounter45408213.reachGoal(linkId)
    }
    Cookies.set('session_last_link_id', linkId, { expires: getVisitorLinkExpireTime() })
    Cookies.set('session_last_link_title', linkTitle, { expires: getVisitorLinkExpireTime() })
  })

  $('a[href="#"]').on('click', function (e) {
    e.preventDefault()
    window.location = '/coming-soon'
  })
})
