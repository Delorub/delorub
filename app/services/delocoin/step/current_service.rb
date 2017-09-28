class Delocoin::Step::CurrentService
  def perform
    step = find_step
    raise 'No current step!' if step.nil?
    step
  end

  private

    def find_step
      Delocoin::Step.where(is_current: true).first
    end
end
