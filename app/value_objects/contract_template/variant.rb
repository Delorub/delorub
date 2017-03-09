class ContractTemplate::Variant
  attr_accessor :title, :id

  def initialize title: '', id: nil
    @id = id
    @title = title
  end
end
