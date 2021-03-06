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
    ('Я согласен с ' + policy_links).html_safe
  end

  def policy_links billing_offer = false
    links = (link_to('политикой конфидециальности', policy_path, class: 'link-default', target: 'blank') +
              ', ' +
              link_to('пользовательским соглашением', terms_path, class: 'link-default', target: 'blank') +
              ' и ' +
              link_to('регламентом оборота монет', billing_terms_path, class: 'link-default', target: 'blank')
            )
    if billing_offer
      links = link_to('договором оферты', billing_offer_path, class: 'link-default', target: 'blank') + ', ' + links
    end
    links
  end

  def payment_policy_checkbox_text
    ('Я ознакомлен и согласен с ' +
      link_to('договором оферты', billing_offer_path, class: 'link-default', target: 'blank')).html_safe
  end

  def city_select_value_for place_id
    place = Place.find_by(id: place_id)
    return if place.blank?
    { id: place.id, label: place.full_name }
  end

  def all_categories_list_for_select
    Category.all.map { |e| { label: e.title, value: e.id, parent_id: e.parent_id } }
  end
end
