class UserPermission < ActiveRecord::Base
  serialize :data, UserPermissionData
  
  belongs_to :user
  
  after_save :destroy_if_empty
  
  delegate :values, to: :data
  
  def method_missing method, *args, &block
    if data.class.have_permission? method
      data.send(method, *args, &block)
    else
      super
    end
  end
  
  def destroy_if_empty
    self.destroy if data.empty?
  end
end
