# == Schema Information
#
# Table name: contract_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContractCategory < ActiveRecord::Base
end