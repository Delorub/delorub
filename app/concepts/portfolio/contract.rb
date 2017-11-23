class Portfolio::Contract < Reform::Form
  property :profile_id
  property :name
  property :description
  property :cover, parse: false

  property :temporary_cover,
    prepopulator: ->(options) {
      self.temporary_cover = ::Portfolio::TemporaryCover.new
      temporary_cover.portfolio_model = model
    },
    populator: ->(fragment:, **) {
      return if fragment['id'].blank?

      item = ::Portfolio::TemporaryCover.find_by(id: fragment['id'].to_i)
      self.temporary_cover = item || ::Portfolio::TemporaryCover.new
      self.cover = File.open(temporary_cover.model.cover.path)
    },
    virtual: true do
    property :id
    property :portfolio_model, parse: false, virtual: true

    def uploaded_or_real_photo
      return portfolio_model.cover if model.cover.blank? && portfolio_model.present?
      model.cover
    end
  end

  def deserialize! document
    return super if !cover.model.new_record? && document[:temporary_cover_attributes].blank?
    return super if check_if_cover_present document[:temporary_cover_attributes]
    return super if check_if_portfolio_items_blank document[:portfolio_items]

    item = PortfolioItem.find_by(id: document[:portfolio_items].first[:id])
    temporary_cover = Portfolio::TemporaryCover.create!(cover: File.open(item.file.path))
    set_temporary_attribute document, temporary_cover.id

    super
  end

  collection :portfolio_items,
    populator: ->(collection:, fragment:, **) {
      return if fragment['id'].blank?
      item = collection.find_by(id: fragment['id'])
      item ? item : collection.append(PortfolioItem.find_by(id: fragment['id']))
    } do
    property :id
    property :file, parse: false
    property :description

    validates :file, presence: true
  end

  validates :name, presence: true, length: { maximum: 200 }
  validates :profile_id, presence: true
  validates :portfolio_items, presence: true

  private

    def check_if_cover_present cover_params
      cover_params.present? && cover_params[:id].present?
    end

    def check_if_portfolio_items_blank items_params
      items_params.blank? || items_params.empty?
    end

    def set_temporary_attribute params, temporary_cover_id
      params[:temporary_cover_attributes] = {} if params[:temporary_cover_attributes].blank?
      params[:temporary_cover_attributes][:id] = temporary_cover_id
    end
end
