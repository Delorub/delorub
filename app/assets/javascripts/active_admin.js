//= require active_admin/base
//= require active_admin/ransack_select2
// require activeadmin_addons/all
// require activeadmin_reorderable
//= require ckeditor/init.js

$(document).ready(function () {
    $('.category_settings_select_cities, .category_settings_type').on('change', function (e) {
        $(this).closest('form').submit()
    })

    $('.btn_save_city_category').on('click', function (e) {
        e.preventDefault()
        var id = $(this).closest('tr').find('#category_id').val()
        var form = $('#form'+id)
        var data = form.serializeArray()
        data.push({name: "settings[description]", value: CKEDITOR.instances['txt-area-'+id].getData()});
        $.ajax({
            url: form.attr('action')+'.json',
            type: "POST",
            data: data,
            success: function (e) {
                alert('Данные сохранены')
            }
        });
    })

})
