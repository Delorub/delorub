class DealsController < ApplicationController
  include Pundit
  inherit_resources

  def show
    authorize resource, :show?
  end
end
