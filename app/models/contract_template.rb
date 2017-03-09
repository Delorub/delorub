# == Schema Information
#
# Table name: contract_templates
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  category_id :integer
#  markup      :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ContractTemplate < ActiveRecord::Base
  serialize :markup, ContractTemplate::Markup

  def markup= value
    return super value unless value.is_a? ActionController::Parameters
    super ContractTemplate::Markup.new.from_parameters value.with_indifferent_access
  end

  def to_redux
    {
      id: id,
      title: title,
      markup: markup.to_redux
    }
  end
end
