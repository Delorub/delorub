class Delocoin::StepDecorator < Draper::Decorator
  decorates Delocoin::Step
  delegate_all

  def one_delocoin_cost
    rate
  end
end
