class User::Settings
  extend JsonSerializable
  include Configurable
  
  def self.default_values
    {
    }
  end
end