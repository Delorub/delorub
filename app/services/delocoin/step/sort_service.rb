class Delocoin::Step::SortService
  def perform
    ActiveRecord::Base.transaction do
      number = 1

      all.map do |step|
        # rubocop:disable Rails/SkipsModelValidations
        step.update_column(:number, number)
        number += 1
      end
    end
  end

  private

    def all
      @_all ||= Delocoin::Step.order('date_from ASC').all
    end
end
