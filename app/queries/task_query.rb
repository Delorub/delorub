class TaskQuery
  attr_accessor :scope, :category, :current_user, :collection

  def initialize collection:, scope:, category:, current_user:
    @collection = collection
    @scope = scope
    @category = category
    @current_user = current_user
  end

  def perform
    apply_visibility
    apply_user if scope == :my
    apply_suggested if scope == :suggested
    apply_category if category
    apply_order
    collection
  end

  private

    def apply_visibility
      return @collection = guest_visibility if current_user.blank?
      return @collection = master_visibility if current_user.master?
      user_visibility
    end

    def guest_visibility
      collection.where{ aasm_state == 'active' }
    end

    def master_visibility
      collection.eager_load(:deal).where do
        (aasm_state == 'active') |
          (user_id == my{ current_user.id }) | (
            (aasm_state == 'in_deal') &
            (deals.profile_id == my{ current_user.profile.id })
          )
      end
    end

    def user_visibility
      collection.where do
        (aasm_state == 'active') |
          (user_id == my{ current_user.id })
      end
    end

    def apply_user
      @collection = collection.by_user current_user
    end

    def apply_suggested
      @collection = collection.by_category_ids current_user.profile.category_ids
    end

    def apply_category
      @collection = collection.by_category_with_descendants category
    end

    def apply_order
      @collection = collection.order('tasks.id DESC')
    end
end
