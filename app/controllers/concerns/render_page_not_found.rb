module RenderPageNotFound
  protected

    def render_page_not_found
      render 'errors/not_found', status: :not_found, formats: :html
    end
end
