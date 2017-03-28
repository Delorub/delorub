class ContractRenderer::HTML < ContractRenderer::Base
  include RenderAnywhere

  attr_reader :contract

  class RenderingController < RenderAnywhere::RenderingController
    def request
      nil
    end
  end

  private

    def do_render
      set_variables
      render_view
      extract_html
    end

    def set_variables
      set_instance_variable 'contract', contract
      set_render_anywhere_helpers 'ReactOnRailsHelper'
    end

    def render_view
      @result = render template: 'contracts/render', layout: false
    end

    def extract_html
      @result = Nokogiri::HTML(@result).css('.text_container').children.to_s
    end
end
