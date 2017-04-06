module LayoutHelper
  def body_css_classnames
    "#{controller_name}_controller #{action_name}_action"
  end

  def navigation_css_class
    "dr-top-nav-#{controller_name == 'main' ? 'main' : 'pages'}"
  end

  def navigation_logo_path
    controller_name == 'main' ? '/images/design/logo1.png' : '/images/design/logo.png'
  end
end
