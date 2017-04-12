class PagesController < ApplicationController
  def show
    @page = Page.find_by slug: params[:unmatched_route]
    return not_found unless @page
  end
end
