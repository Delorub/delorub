class Delocoin::StepDecorator < Draper::Decorator
  decorates Delocoin::Step
  delegate_all

  def number
    id
  end

  def one_delocoin_cost
    rate
  end
end
