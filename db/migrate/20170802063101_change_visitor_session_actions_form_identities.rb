class ChangeVisitorSessionActionsFormIdentities < ActiveRecord::Migration[5.1]
  class VisitorSessionAction < ActiveRecord::Base; end

  def up
    VisitorSessionAction.where(action_type: 'post_form', identity: 'index_search_form').find_each do |action|
      action.update_column :identity, 'main_form'
    end
  end

  def down; end
end
