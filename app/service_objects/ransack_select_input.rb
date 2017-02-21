class RansackSelectInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge options
  end

  private

    def options
      {
        'class': css_class,
        'data-field': field,
        'data-url': url,
        'data-response_root': response_root,
        'data-display_name': display_name,
        'data-minimum_input_length': minimum_input_length,
        'data-width': width,
        'data-selected': selected
      }
    end

    def relation
      @relation ||= !@object.nil? ? @object.send(attributized_method_name) : ''
    end

    def css_class
      ['select2-ransack-ajax'].concat([@options[:class]] || []).join(' ')
    end

    def field
      @options[:fields] || 'by_search_in'
    end

    def url
      @options[:url] || ''
    end

    def response_root
      @options[:response_root] || @options[:url].to_s.split('/').last
    end

    def display_name
      @options[:display_name] || 'name'
    end

    def minimum_input_length
      @options[:minimum_input_length] || 1
    end

    def width
      @options[:width] if @options[:width]
    end

    def selected
      relation.try(opts['data-display_name'].to_sym)
    end
end
