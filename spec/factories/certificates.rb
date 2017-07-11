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

FactoryGirl.define do
  factory :certificate do
    profile
    file do
      Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'support', 'certificate', 'files', 'image.png')))
    end
  end
end
