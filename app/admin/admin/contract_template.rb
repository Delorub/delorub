ActiveAdmin.register ContractTemplate, namespace: :admin do
  permit_params :category_id, :title, markup: [
    { questions: [
      :title,
      { variants: [ :title ] }
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
      @contract_template.markup.questions << ContractTemplateData::Question.new(id: 0, title: 'Форма предпринимательства')
      @contract_template.markup.questions[0].variants << ContractTemplateData::Variant.new(id: 0, title: 'Индивидуальное предпринимательство')
      @contract_template.markup.questions[0].variants << ContractTemplateData::Variant.new(id: 1, title: 'ООО')
      @contract_template.markup.questions << ContractTemplateData::Question.new(id: 1, title: 'Форма расчета')
      @contract_template.markup.questions[1].variants << ContractTemplateData::Variant.new(id: 0, title: 'Безналичный платеж')
      @contract_template.markup.questions[1].variants << ContractTemplateData::Variant.new(id: 1, title: 'Наличный расчет')
      @contract_template.markup.text = ContractTemplateData::Text.new data: '<h1>Договор купли-продажи</h1><p>По договору купли-продажи продавец автомобиля обязуется передать автомобиль в собственность покупателю, а покупатель обязуется принять автомобиль и уплатить за него определенную денежную сумму, его цену. Нотариальное заверение договора купли-продажи автомобиля не требуется.</p>'
      render partial: 'form', layout: 'active_admin/fullscreen'
    end

    def create
      @contract_template = ContractTemplate.new(permitted_params[:contract_template])
      if @contract_template.save
        redirect_to resource_path and return
      end
      render partial: 'form', layout: 'active_admin/fullscreen'
    end

    def update
      @contract_template = ContractTemplate.find params[:id]
      @contract_template.attributes = permitted_params[:contract_template]
      if @contract_template.save
        redirect_to resource_path and return
      end
      render partial: 'form', layout: 'active_admin/fullscreen'
    end

    def edit
      @contract_template = ContractTemplate.find params[:id]
      render partial: 'form', layout: 'active_admin/fullscreen'
    end
  end
end
