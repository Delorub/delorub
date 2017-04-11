module HelpHelper
  def help_category_answers category
    @answers.select { |e| e.help_category_id == category.id }
  end
end
