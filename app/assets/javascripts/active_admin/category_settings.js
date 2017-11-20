function checkNumberCharacters (string, number) {
    return $('<b/>').addClass('length-symbols').css({color: (string.length > number) ? 'red' : 'blue'}).text('Символов - ' + string.length)
}

function allowedLength (element) {
    return element.hasClass('category_settings_field') ? 80 : 180
}

function existingFieldWithSameValue (value) {
    var descriptions = $(".seo_description").filter(function() { return $(this).val() === value })
    var titles = $(".seo_title").filter(function() { return $(this).val() === value })
    var countFieldsWithSameText = titles.length + descriptions.length

    return (countFieldsWithSameText > 1 && value !== '') ? true : false
}

function addLengthString (element, string) {
    element.find('.length-symbols').remove()
    element.append(string)
}

function addClassExistingFieldValue (element) {
    if (existingFieldWithSameValue(element.val())) {
        element.addClass('existing-value')
    } else {
        element.removeClass('existing-value')
    }
}

function eachFieldsWithSameText () {
    $('.seo_title, .seo_description').each(function (e) {
        addClassExistingFieldValue($(this))
    })
}

$(document).ready(function () {
    $('.category_settings_select_cities, .category_settings_type, .category_settings_category').on('change', function (e) {
        $(this).closest('form').submit()
    })

    $('.btn_save_city_category').on('click', function (e) {
        e.preventDefault()
        var id = $(this).closest('tr').find('#category_id').val()
        var form = $('#form'+id)
        var data = form.serializeArray()
        data.push({name: "settings[description]", value: CKEDITOR.instances['txt-area-'+id].getData()})
        $.ajax({
            url: form.attr('action')+'.json',
            type: "PUT",
            data: data,
            success: function (e) {
                alert('Данные сохранены')
            }
        })
    })

    $('.category_settings_field, .category_settings_textarea').each(function (e) {
        addLengthString($(this).closest('td'), checkNumberCharacters($(this).val(), allowedLength($(this))))
    })

    $('.category_settings_field, .category_settings_textarea').keyup(function(){
        addLengthString($(this).closest('td'), checkNumberCharacters($(this).val(), allowedLength($(this))))
    })

    eachFieldsWithSameText()
    $('.seo_title, .seo_description').keyup(function (e) {
        eachFieldsWithSameText()
    })
})
