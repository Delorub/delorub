module FormHelper
  def error_block_for field_name
    return if resource.errors[field_name].count == 0
    "<span class=\"error\">#{resource.errors[field_name].first}</span>".html_safe
  end

  def error_class_for field_name
    return if resource.errors[field_name].count == 0
    ' dr-task-div-error'
  end

  def split_collection_to_columns collection
    collection.each_slice(4).to_a
  end
end
