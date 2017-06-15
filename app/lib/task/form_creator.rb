class Task::FormCreator
  attr_reader :form, :model

  def initialize form
    @form = form
    @model = nil
  end

  def perform
    Task.transaction do
      @form.save do |hash|
        form.model.attributes = hash.slice(*params)
        form.model.file_ids = file_ids(hash)
        form.model.save
        @model = form.model
      end
    end
  end

  def last_error
    return unless model
    return if model.errors.empty?
    model.errors[model.errors.keys.first].first
  end

  private

    def file_ids hash
      hash[:files].map { |e| e[:id].to_i }
    end

    def params
      [
        :title, :description, :category_id, :date_type, :date_actual,
        :date_from, :date_to, :price_type,
        :price_exact, :price_from, :price_to, :place_id, :place_address,
        :contract_type # , :date_actual_date, :date_actual_time
      ]
    end
end
