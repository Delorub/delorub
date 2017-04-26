module HelpHelper
  def help_category_answers category
    @answers.select { |e| e.help_category_id == category.id }
  end

  def split_collection_to_columns collection
    collection.each_slice(4).to_a
  end
end
