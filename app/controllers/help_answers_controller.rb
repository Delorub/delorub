class HelpAnswersController < ApplicationController
  inherit_resources

  def show
    @help_question = HelpQuestion.new
  end
end
