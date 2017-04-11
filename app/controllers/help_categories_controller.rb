class HelpCategoriesController < ApplicationController
  inherit_resources

  def index
    @help_question = HelpQuestion.new
    if params[:query]
      fetch_answers_from_search
      redirect_if_one_result
    else
      fetch_all_answers
    end
  end

  private

    def redirect_if_one_result
      return unless @answers.count == 1
      redirect_to help_answer_path(
        @answers.first.help_category,
        @answers.first,
        query: params[:query]
      )
    end

    def fetch_answers_from_search
      @answers = HelpAnswerSearch.new(query: params[:query], per_page: nil).all
    end

    def fetch_all_answers
      @answers = HelpAnswer.order(:position)
    end
end
