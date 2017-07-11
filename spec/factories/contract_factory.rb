# == Schema Information
#
# Table name: contracts
#
#  id          :integer          not null, primary key
#  template_id :integer
#  data        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :contract do
    association :template, factory: :contract_template
  end
end
