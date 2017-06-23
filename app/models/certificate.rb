# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  file       :string
#  profile_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_certificates_on_profile_id  (profile_id)
#

class Certificate < ApplicationRecord
  mount_uploader :file, CertificateUploader

  belongs_to :profile

  validates :profile_id, :file, presence: true
end
