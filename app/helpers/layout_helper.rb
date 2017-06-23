module LayoutHelper
  def body_css_classnames
    "#{controller_name}_controller #{action_name}_action#{landing_classnames}"
  end

  def navigation_css_class
    "dr-top-nav-#{show_main_design? ? 'main' : 'pages'}"
  end

  def landing_classnames
    '  dr-landing' if controller_name == 'custom_pages'
  end

  def navigation_logo_path
    show_main_design? ? '/images/design/logo1.svg' : '/images/design/logo.png'
  end

  def show_main_design?
    %w[main custom_pages].include? controller_name
  end

  def show_side_menu?
    user_signed_in? && controller_name != 'custom_pages'
  end

  def container_css_classes
    show_side_menu? ? '' : ' dr-container-without-sidemenu without-sidemenu'
  end

  def global_container?
    @global_container
  end
end
