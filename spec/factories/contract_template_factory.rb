# == Schema Information
#
# Table name: contract_templates
#
#  id          :integer          not null, primary key
#  title       :string
#  category_id :integer
#  markup      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :contract_template do
    category_id 1
    title 'ContractTemplate'
  end
end
