class Billing::Transaction
  extend Uber::Callable

  def self.call options, *_
    result = ActiveRecord::Base.transaction { yield }
    result[0] != Pipetree::Railway::Left
  end
end
