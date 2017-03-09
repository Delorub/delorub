class ContractTemplate::Question
  attr_accessor :title, :id, :variants

  def initialize title: '', id: nil, variants: []
    @id = id
    @title = title
    @variants = variants
  end
end
