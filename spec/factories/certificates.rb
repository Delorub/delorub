FactoryGirl.define do
  factory :certificate do
    profile
    file do
      Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'support', 'certificate', 'files', 'image.png')))
    end
  end
end
