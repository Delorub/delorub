module Enumerize
  module Hooks
    module SimpleFormBuilderExtension
      private

      def add_input_options_for_enumerized_attribute(attribute_name, options)
        # This line changed from
        # object.to_model.class
        # to
        # object.model.class
        if object.is_a? Trailblazer::Rails::Form
          klass = object.model.class
        else
          klass = object.to_model.class
        end

        if klass.respond_to?(:enumerized_attributes) && (attr = klass.enumerized_attributes[attribute_name])
          options[:collection] ||= attr.options

          if attr.kind_of?(Enumerize::Multiple) && options[:as] != :check_boxes
            options[:input_html] = options.fetch(:input_html, {}).merge(:multiple => true)
          end
        end
      end
    end
  end
end
