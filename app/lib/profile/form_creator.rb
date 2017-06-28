class Profile::FormCreator
  attr_reader :form, :model, :hash

  def initialize form
    @form = form
    @model = nil
    @hash = nil
  end

  def perform
    Profile.transaction do
      @form.save do |form_hash|
        @hash = form_hash
        @model = form.model
        assign_hash_to_profile
        assign_hash_to_user
        model[:profile].save
        model[:user].save
        user_temporary_photo.destroy if user_temporary_photo.present?
      end
    end
  end

  def last_error
    # return unless model
    # return if model.errors.empty?
    # model.errors[model.errors.keys.first].first
  end

  private

    def assign_hash_to_profile
      @model[:profile].attributes = hash[:profile].with_indifferent_access.slice(*profile_params)
      @model[:profile].category_ids = category_ids
      @model[:profile].portfolio_item_ids = portfolio_item_ids
      @model[:profile].certificate_ids = certificate_ids
      @model[:profile].working_days = []
    end

    def category_ids
      hash[:profile]['categories'].map { |e| e[:id].to_i }
    end

    def portfolio_item_ids
      hash[:profile]['portfolio_items'].map { |e| e[:id].to_i }
    end

    def certificate_ids
      hash[:profile]['certificates'].map { |e| e[:id].to_i }
    end

    def assign_hash_to_user
      @model[:user].place_id = hash[:user]['place_id']
      if hash[:user]['temporary_photo_id'].present?
        @model[:user].remove_photo!
        @model[:user].photo = user_temporary_photo.photo.file
      end
    end

    def user_temporary_photo
      User::TemporaryPhoto.find_by(id: hash[:user]['temporary_photo_id'])
    end

    def assign_date
      @model.date_actual = nil
      @model.date_interval_from = nil
      @model.date_interval_to = nil
      case model.date_type.to_sym
      when :actual
        @model.date_actual = Time.zone.parse "#{hash[:date_actual_date]} #{hash[:date_actual_time]}"
      when :interval
        @model.date_interval_from = Time.zone.parse hash[:date_interval_from_date]
        @model.date_interval_to = Time.zone.parse hash[:date_interval_to_date]
      end
    end

    def profile_params
      [
        :about, :place_id, :have_car, :have_instrument, :can_departure, :price_type, :working_hours_from,
        :working_hours_to, :price_hourly, :price_project
      ]
    end
end
