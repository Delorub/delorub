class Delocoin::StepDecorator < Draper::Decorator
  decorates Delocoin::Step
  delegate_all

  def one_delocoin_cost
    rate
  end

  def future?
    (date_from - Time.zone.today).positive?
  end

  def past?
    (date_from - Time.zone.today).negative?
  end
end
