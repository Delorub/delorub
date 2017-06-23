# == Schema Information
#
# Table name: user_temporary_photos
#
#  id    :integer          not null, primary key
#  photo :string
#

class User::TemporaryPhoto < ApplicationRecord
  mount_uploader :photo, UserPhotoUploader
end
