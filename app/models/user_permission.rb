# == Schema Information
#
# Table name: user_permissions
#
#  id         :integer          not null, primary key
#  data       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class UserPermission < ActiveRecord::Base
  PERMISSIONS = {
    admin:
    {
      dashboard: [],
      search: [],
      place: [],
      user_billing_log: [],
      task: [:view, :edit, :delete],
      category: [:view, :edit, :delete],
      news: [:view, :edit, :delete],
      user: [:view, :edit, :delete, :permissions, :billing],
      page: [:view, :edit],
      reply: [],
      contract_template: [],
      help: []
    },

    editor:
    {
      dashboard: [],
      user: [:view, :permissions, :block, :billing],
      news: [],
      task: [],
      reply: []
    },

    superadmin: []
  }.freeze

  serialize :data, UserPermissionData

  belongs_to :user

  after_save :destroy_if_empty

  delegate :values, to: :data

  UserPermissionData.permissions.each do |permission|
    define_method permission do
      data.send(permission)
    end

    define_method "#{permission}?" do
      data.send("#{permission}?")
    end

    define_method "#{permission}=" do |value|
      data.send("#{permission}=", value)
    end
  end

  def destroy_if_empty
    destroy if data.empty?
  end
end
