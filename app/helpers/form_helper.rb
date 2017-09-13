module FormHelper
  def error_block_for field_name
    return if resource.errors[field_name].count.zero?
    "<span class=\"error\">#{resource.errors[field_name].first}</span>".html_safe
  end

  def error_class_for field_name
    return if resource.errors[field_name].count.zero?
    ' dr-task-div-error'
  end

  def split_collection_to_columns collection
    collection.each_slice(4).to_a
  end

  def policy_checkbox_text
    ('Я согласен с ' +
      link_to('правилами сервиса', terms_path, class: 'link-default', target: 'blank') +
      ' и ' +
      link_to('политикой обработки персональных данных', policy_path, class: 'link-default', target: 'blank')).html_safe
  end

  def city_select_value_for place_id
    place = Place.find_by(id: place_id)
    return if place.blank?
    { id: place.id, label: place.full_name }
  end
end
