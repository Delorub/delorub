# == Schema Information
#
# Table name: user_permissions
#
#  id         :integer          not null, primary key
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

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
