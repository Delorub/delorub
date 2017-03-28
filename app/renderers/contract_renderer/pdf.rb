class ContractRenderer::PDF < ContractRenderer::Base
  include RenderAnywhere

  attr_reader :html

  private

    def do_render
      render_html
      render_pdf_from_html
    end

    def render_html
      @html = ContractRenderer::HTML.new(contract: @contract).perform
      @html = render inline: html, layout: 'contract/render_pdf'
    end

    def render_pdf_from_html
      WickedPdf.new.pdf_from_string(html)
    end
end
