class PageNotFoundController < ActionController::Base
  include RenderPageNotFound

  def index
    render_page_not_found
  end
end
