require 'grape-swagger'

class ApplicationAPI < Grape::API
  format :json
  cascade true

  default_error_status 400

  mount Api::V10

  add_swagger_documentation
end
