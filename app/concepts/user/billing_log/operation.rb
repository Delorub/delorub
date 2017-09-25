class User::BillingLog::Operation < Trailblazer::Operation
  class Create < Trailblazer::Operation
    step Model(::User::BillingLog, :new)
    step Policy::Pundit(User::BillingLogPolicy, :create?)
    step Contract::Build(constant: ::User::BillingLog::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end

  class Finish < Trailblazer::Operation
    step Model(::User::BillingLog, :find_by)
    step Policy::Pundit(User::BillingLogPolicy, :finish?)
    step :enough_balance?
    step ->(options, model:, **_) {
      # TODO: make by sql
      model.user.balance = model.user.balance + model.sum
      model.user.save! && model.save!
      model.finish!
    }

    def enough_balance? options, model:, **_
      (model.user.balance + model.sum).positive?
    end
  end

  class Fail < Trailblazer::Operation
    step Model(::User::BillingLog, :find_by)
    step Policy::Pundit(User::BillingLogPolicy, :fail?)
    success ->(options, model:, **_) {
      model.fail!
      model.save
    }
  end
end
