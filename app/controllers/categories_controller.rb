class CategoriesController < ApplicationController
  include Pundit
  inherit_resources

  private

  def end_of_association_chain
    CategoryQuery.new(collection: super).perform
  end
end
