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
    step :update_user_balance
    success :run_nested_operation

    def update_user_balance options, model:, **_
      model.finish!
      sql = "UPDATE users SET balance = #{model.user.balance + model.sum} WHERE id = #{model.user_id}"
      ActiveRecord::Base.connection.execute(sql)
      model.save
    end

    def enough_balance? options, model:, **_
      (model.user.balance + model.sum).positive?
    end

    def run_nested_operation options, model:, **_
      return if model.finish_after.blank?

      case model.finish_after.class.name
        when Billing::Delocoin::Buy
          Billing::Delocoin::Buy::Operation::Finish.call(id: model.finish_after.id)
      end
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
