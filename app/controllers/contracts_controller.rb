class ContractsController < ApplicationController
  def new
    @contract_template = ContractTemplate.find params[:template_id]
    @contract = Contract.new(template: @contract_template)
  end

  def create
    pdf = ContractRenderer::PDF.new(contract: @contract).perform

    save_path = Rails.root.join('filename.pdf')
    File.open(save_path, 'wb') do |file|
      file << pdf
    end

    render pdf: 'filename.pdf', encoding: "UTF-8"
  end
end
