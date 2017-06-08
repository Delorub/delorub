# == Schema Information
#
# Table name: user_omniauth_relations
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  provider    :string
#  external_id :string
#  data        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_omniauth_relations_on_provider_and_external_id  (provider,external_id) UNIQUE
#  index_user_omniauth_relations_on_user_id                   (user_id)
#

class User::OmniauthRelation < ApplicationRecord
  belongs_to :user

  serialize :data
end
