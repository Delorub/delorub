import 'libs/delorub/tinymce'

$(document).ready(function() {
  tinymce.init({
    selector: '#news_content',
    language: 'ru',
    menubar: false
  })
});
