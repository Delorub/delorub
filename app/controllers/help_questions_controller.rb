class HelpQuestionsController < ApplicationController
  inherit_resources

  private

    def permitted_params
      params.permit(help_question: [:name, :email, :content])
    end
end
