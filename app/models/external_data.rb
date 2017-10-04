# == Schema Information
#
# Table name: external_data
#
#  id                  :integer          not null, primary key
#  data                :text
#  uid                 :string
#  source              :string
#  state               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  payload             :text
#  parser_filter_state :string
#

class ExternalData < ApplicationRecord
  include AASM

  serialize :data, JSON
  serialize :payload, JSON

  aasm(:state) do
    state :new, initial: true
    state :approved, :rejected

    event :approve do
      transitions to: :approved
    end

    event :reject do
      transitions to: :rejected
    end
  end

  aasm(:parser_filter_state) do
    state :parser_new, initial: true
    state :parser_approved, :parser_rejected

    event :parser_approve do
      transitions to: :parser_approved
    end

    event :parser_reject do
      transitions to: :parser_rejected
    end
  end
end
