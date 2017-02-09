module RenderPageNotFound
  protected

    def render_page_not_found
      render file: 'public/404', formats: [:html], layout: false, status: :not_found
    end
end
