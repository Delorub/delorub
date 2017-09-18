class User::BillingLog::Operation < Trailblazer::Operation
  class Create < Trailblazer::Operation
    step Model(::User::BillingLog, :new)
    step Contract::Build(constant: ::User::BillingLog::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end

  class Finish < Trailblazer::Operation
    step Model(::User::BillingLog, :find_by)
    step ->(options, model:, **_) {
      model.finish!
      # TODO: make sql
      model.user.balance = model.user.balance + model.sum
      model.user.save

      model.save
    }
  end

  class Fail < Trailblazer::Operation
    step Model(::User::BillingLog, :find_by)
    step ->(options, model:, **_) {
      model.fail!
      model.save
    }
  end
end
