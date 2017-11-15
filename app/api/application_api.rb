require 'grape-swagger'

class ApplicationAPI < Grape::API
  helpers Grape::AuthHelpers, Grape::PunditHelpers

  format :json
  cascade true

  default_error_status 400

  mount Api::V10

  add_swagger_documentation
end
