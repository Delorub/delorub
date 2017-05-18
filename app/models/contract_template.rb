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

class ContractTemplate < ActiveRecord::Base
  serialize :markup, ContractTemplateData::Markup

  belongs_to :category, class_name: 'ContractCategory'

  #validates :title, :category, presence: true

  def markup= value
    return super value unless value.is_a? ActionController::Parameters
    super ContractTemplateData::Markup.new.from_parameters value.with_indifferent_access
  end

  def to_redux
    {
      id: id,
      title: title,
      markup: markup.to_redux
    }
  end

  def to_contract_app
    {
      id: id,
      title: title,
      markup: markup.to_contract_app
    }
  end
end
