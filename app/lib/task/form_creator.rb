class Task::FormCreator
  attr_reader :form, :model, :hash

  def initialize form
    @form = form
    @model = nil
    @hash = nil
  end

  def perform
    Task.transaction do
      @form.save do |form_hash|
        @hash = form_hash
        @model = form.model
        assign_hash_to_model
        model.save
      end
    end
  end

  def last_error
    return unless model
    return if model.errors.empty?
    model.errors[model.errors.keys.first].first
  end

  private

    def assign_hash_to_model
      model.attributes = hash.slice(*params)
      model.file_ids = file_ids
      assign_date
    end

    def assign_date
      model.date_actual = nil
      model.date_interval_from = nil
      model.date_interval_to = nil
      case model.date_type.to_sym
      when :actual
        model.date_actual = Time.zone.parse "#{hash[:date_actual_date]} #{hash[:date_actual_time]}"
      when :interval
        model.date_interval_from = Time.zone.parse hash[:date_interval_from_date]
        model.date_interval_to = Time.zone.parse hash[:date_interval_to_date]
      end
    end

    def file_ids
      hash[:files].map { |e| e[:id].to_i }
    end

    def params
      [
        :title, :description, :category_id, :date_type, :price_type, :price_exact,
        :price_from, :price_to, :place_id, :place_address, :contract_type
      ]
    end
end
