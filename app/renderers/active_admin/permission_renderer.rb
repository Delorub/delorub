class ActiveAdmin::PermissionRenderer < Struct.new(:template, :form, :resource)
  def render
    render_form
  end

  def method_missing method, *args, &block
    template.send method, *args, &block
  end

  private

    def render_form
      render_part resource.data.class.pretty_permissions
    end
    
    def render_part data, level: 1, prefix: nil
      form.inputs style: "padding-left: 20px;" do
        data.each do |k, v|
          render_level title: make_title(prefix, k), form: form, level: level, v: v
        end
      end
    end
    
    def render_level title:, form:, level:, v:
      render_input title
      render_description title, form: form
      if not v.nil? and not v.empty?
        render_part v, level: level + 1, prefix: title
      end
    end

    def render_input k
      form.input k, as: :boolean
    end
    
    def make_title prefix, k
      [prefix, k].select { |e| not e.nil? }.map(&:to_s).join('_').to_sym
    end
    
    def render_description k, form:
      form.small I18n.t!("activerecord.attributes.user_permission.#{k}_description") rescue false
    end
end
