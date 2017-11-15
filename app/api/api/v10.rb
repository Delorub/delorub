class Api::V10 < Grape::API
  mount Api::V10::SmsConfirmations
  mount Api::V10::Tasks
  mount Api::V10::Profiles
  mount Api::V10::Categories
  mount Api::V10::Places
  mount Api::V10::Users
  mount Api::V10::Billings
  mount Api::V10::Portfolios
  mount Api::V10::PortfolioItems
end
