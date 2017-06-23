FactoryGirl.define do
  factory :portfolio_item do
    profile
    file do
      Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'support', 'portfolio_item', 'files', 'image.png')))
    end
  end
end
