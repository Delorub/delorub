class VueSelectCollectionInput < SimpleForm::Inputs::CollectionInput
  def input wrapper_options = nil
    component_props = default_component_props.merge input_html_options.delete(:component)

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    content_tag 'selectbox',
      hidden_field_slot(merged_input_options).html_safe,
      component_props
  end

  private

    def hidden_field_slot merged_input_options
      binded_attributes = { ':value': 'props.value' }
      '<template slot="input" scope="props">'.html_safe +
        @builder.hidden_field(attribute_name, merged_input_options.merge(binded_attributes)) +
        '</template>'.html_safe
    end

    def default_component_props
      {
        'value': object.send(attribute_name),
        ':options': collection_to_options.to_json,
        ':labels': collection_to_labels.to_json
      }
    end

    def collection_to_options
      _, value_method = detect_collection_methods

      collection.map { |e| e.send(value_method) }
    end

    def collection_to_labels
      label_method, value_method = detect_collection_methods

      collection.map { |e| { label: e.send(label_method), value: e.send(value_method) } }
    end
end
