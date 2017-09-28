class Delocoin::Step::LastService
  def perform
    step = find_step
    raise 'No last step!' if step.nil?
    step
  end

  private

    def find_step
      Delocoin::Step.order('date_from ASC').last.decorate
    end
end
