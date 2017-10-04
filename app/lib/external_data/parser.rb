class ExternalData::Parser
  attr_reader :category, :payload, :query

  def initialize
    @data = []
    @stopwords = []
  end

  def perform query, category, payload = {}
    @category = category
    @payload = payload
    @query = query
    fetch_data(query)
    save_data
  end

  private

    def add_item row
      uid = generate_uid(row)
      return if ExternalData.exists? uid: uid

      @data << ExternalData.new(
        uid: uid,
        data: row,
        source: source_name,
        parser_filter_state: parser_filter_state(row),
        payload: {
          query: query,
          category: category.id
        }.merge(payload)
      )
    end

    def parser_filter_state row
      ExternalData::Filter.new(text(row), category).state
    end

    def save_data
      @data.each(&:save!)
    end

    def source_name
      self.class.name.split('::')[2..-1].map(&:downcase).join('_')
    end
end
