FactoryGirl.define do
  factory :user_permission do
    user

    factory :editor_user_permission do
      editor true
    end

    factory :superadmin_user_permission do
      superadmin true
    end

    factory :admin_user_permission do
      admin true
    end
  end
end
