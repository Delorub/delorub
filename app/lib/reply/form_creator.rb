class Reply::FormCreator
  attr_reader :form, :model, :hash

  def initialize form
    @form = form
    @model = nil
    @hash = nil
  end

  def perform
    Reply.transaction do
      @form.save do |form_hash|
        @hash = form_hash
        @model = form.model
        assign_hash_to_model
        model.save
      end
    end
  end

  def last_error
    return unless model
    return if model.errors.empty?
    model.errors[model.errors.keys.first].first
  end

  private

    def assign_hash_to_model
      model.attributes = hash.slice(*reply_params)
    end

    def reply_params
      [:content, :task_id]
    end
end
