class Delocoin::Step::NextYearService
  def perform
    step = find_step
    raise 'No next year step!' if step.nil?
    step
  end

  private

    def find_step
      Delocoin::Step.where('date_from < ?', date.to_date).order('date_from DESC').first.try(:decorate)
    end

    def date
      Time.zone.now + 1.year
    end
end
