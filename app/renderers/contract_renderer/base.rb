class ContractRenderer::Base
  attr_reader :contract

  def initialize contract:
    @contract = contract
  end

  def perform
    do_render
  end
end
