module Searchable::HelpAnswer
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:title, :content, :synonyms, :category], language: :russian
  end

  def search_data
    {
      title: title,
      content: content,
      synonyms: synonyms,
      category: help_category.title
    }
  end
end
