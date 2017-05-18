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

class Contract < ActiveRecord::Base
  serialize :data, ContractData

  belongs_to :template, class_name: 'ContractTemplate'

  def data= value
    return super value unless value.is_a? ActionController::Parameters
    super ContractData.new.from_parameters value.with_indifferent_access
  end

  def to_redux
    {
      data: data.to_redux
    }
  end
end
