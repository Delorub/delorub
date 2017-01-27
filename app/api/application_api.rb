require 'grape-swagger'

class ApplicationAPI < Grape::API
  format :json
  cascade true
  
  mount Api::V10
  
  add_swagger_documentation
end
