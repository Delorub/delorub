class ExternalData::Filter
  attr_reader :text, :category

  def initialize text, category
    @text = text
    @category = category
  end

  def perform
    return false if text.split.blank?
    category.external_data_settings.stopwords.each do |word|
      regexp = Regexp.new(Regexp.escape(word), Regexp::IGNORECASE)
      return false if regexp.match(text)
    end
    true
  end

  def state
    perform ? 'parser_approved' : 'parser_rejected'
  end
end
