class VisitorSession::ActiveAdminQuery
  def perform
    VisitorSession.unscoped
  end

  private

    def apply_user
      @collection = collection.by_user current_user
    end

    def apply_category
      @collection = collection.by_category_with_descendants category
    end

    def apply_order
      @collection = collection.order('id DESC')
    end
end
