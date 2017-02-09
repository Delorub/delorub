class Editor::User::BillingLogPolicy < AdminPolicy
  private

    def granted?
      false
    end
end