ActiveAdmin.register ContractTemplate, namespace: :admin do
  permit_params :category_id, :title, markup: [
    { questions: [
      :title,
      { variants: [:title] }
    ] },
    :text
  ]

  index download_links: false do
    column :title
  end

  show do
    h3 contract_template.title
    para contract_template.markup.text.data.html_safe
  end

  controller do
    def new
      @contract_template = ContractTemplate.new
      render partial: 'form', layout: 'active_admin/fullscreen'
    end

    def create
      @contract_template = ContractTemplate.new(permitted_params[:contract_template])
      return redirect_to resource_path if @contract_template.save
      render partial: 'form', layout: 'active_admin/fullscreen'
    end

    def update
      @contract_template = ContractTemplate.find params[:id]
      @contract_template.attributes = permitted_params[:contract_template]
      return redirect_to resource_path if @contract_template.save
      render partial: 'form', layout: 'active_admin/fullscreen'
    end

    def edit
      @contract_template = ContractTemplate.find params[:id]
      render partial: 'form', layout: 'active_admin/fullscreen'
    end
  end
end
