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
    show_main_design? ? '/images/design/logo1.svg' : '/images/design/logo.svg'
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

  def price_format value
    number_with_delimiter value, delimiter: ' '
  end

  def seo_title text
    content_for :seo_title, text
  end

  def meta_tag tag, text
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag tag, default_text = ''
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def canonical_link url
    content_for(:canonical, tag(:link, rel: :canonical, href: URI.join(root_url, url).to_s)) if url
  end
end
