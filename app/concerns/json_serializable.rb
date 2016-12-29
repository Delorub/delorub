module JsonSerializable
  def load json
    new json ? ActiveSupport::JSON.decode(json) : {}
  end

  def dump object
    ActiveSupport::JSON.encode object
  end
end
