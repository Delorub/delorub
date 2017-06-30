class Comment::FormCreator < BaseCreator
  def perform
    Comment.transaction do
      @form.save do |form_hash|
        @hash = form_hash
        @model = form.model
        assign_hash_to_model
        model.save
      end
    end
  end

  private

    def assign_hash_to_model
      model.attributes = hash.slice(*comment_params)
    end

    def comment_params
      [:text]
    end
end
