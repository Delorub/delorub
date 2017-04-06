module LayoutHelper
  def body_css_classnames
    "#{controller_name}_controller #{action_name}_action"
  end

  def navigation_css_class
    "dr-top-nav-#{controller_name == 'home' ? 'main' : 'pages'}"
  end

  def navigation_logo_path
    controller_name == 'home' ? '/images/design/logo1.png' : '/images/design/logo.png'
  end
end
