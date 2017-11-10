class ExternalData::FilterAll
  def perform
    ExternalData.find_each do |external_data|
      process external_data
    end
  end

  private

    def process external_data
      cat = category(external_data.payload['category'])
      return if cat.nil?

      text = ExternalData::Presenter.for(external_data).fulltext

      # rubocop:disable Rails/SkipsModelValidations
      external_data.update_column(:parser_filter_state, ExternalData::Filter.new(text, cat).state)
    end

    def category id
      categories[id]
    end

    def categories
      @_categories ||= Category.all.map do |category|
        [category.id, category]
      end.to_h
    end
end
