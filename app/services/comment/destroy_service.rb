class Comment::DestroyService
  attr_reader :object

  def initialize object
    @object = object
  end

  def perform
    ActiveRecord::Base.transaction do
      object.destroy
      delete_child_foreign_keys
    end
  end

  private

  def delete_child_foreign_keys
    object.comments.update_all(parent_id: nil)
  end
end
