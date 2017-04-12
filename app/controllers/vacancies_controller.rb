class VacanciesController < ApplicationController
  inherit_resources

  private

    def end_of_association_chain
      super.visible
    end
end
