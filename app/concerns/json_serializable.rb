module JsonSerializable
  def self.load json
    new json ? ActiveSupport::JSON.decode(json) : {}
  end

  def self.dump object
    ActiveSupport::JSON.encode object
  end
end
