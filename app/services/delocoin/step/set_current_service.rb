class Delocoin::Step::SetCurrentService
  def perform
    ActiveRecord::Base.transaction do
      step_id = current_step_id
      all.map do |step|
        # rubocop:disable Rails/SkipsModelValidations
        step.update_column(:is_current, step.id == step_id)
      end
    end
  end

  private

    def current_step_id
      min_value = nil
      return_id = nil

      all.each do |e|
        value = (e.date_from - Time.zone.today).to_i
        next if value.positive?
        if min_value.nil? || value > min_value
          min_value = value
          return_id = e.id
        end
      end

      return_id
    end

    def all
      Delocoin::Step.all
    end
end
