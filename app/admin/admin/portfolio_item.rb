ActiveAdmin.register PortfolioItem do
  permit_params :title, :file, :profile_id

  form do |f|
    inputs 'Основное' do
      input :title
      input :file
      input :profile
    end
    actions
  end

  index do
    selectable_column
    column :title
    column :profile do |item|
      link_to item.profile.name, admin_profile_path(item.profile)
    end
    actions
  end

  show do
    h3 portfolio_item.title
    attributes_table_for portfolio_item do
      row :title
      row :profile do |item|
        link_to item.profile.name, admin_profile_path(item.profile)
      end
      h3 'Комментарии'
      table_for portfolio_item.comments do
        column :id do |comment|
          link_to comment.id, admin_comment_path(comment)
        end
        column :user do |comment|
          link_to comment.user.name, admin_user_path(comment.user)
        end
        column :text
      end
    end
  end
end
