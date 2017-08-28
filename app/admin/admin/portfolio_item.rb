ActiveAdmin.register PortfolioItem do
  permit_params :file, :profile_id

  form do |f|
    inputs 'Основное' do
      input :file
      input :profile
    end
    actions
  end

  index do
    selectable_column
    column :preview do |item|
      image_tag item.file.preview.url
    end
    column :profile do |item|
      link_to item.profile.user.decorate.name, admin_profile_path(item.profile)
    end
    actions
  end

  show do
    attributes_table_for portfolio_item do
      row :profile do |item|
        link_to item.profile.user.decorate.name, admin_profile_path(item.profile)
      end
      row :thumb do |item|
        image_tag item.file.thumb.url
      end
      h3 'Комментарии'
      table_for portfolio_item.comments do
        column :id do |comment|
          link_to comment.id, admin_comment_path(comment)
        end
        column :user do |comment|
          link_to comment.user.decorate.name, admin_user_path(comment.user)
        end
        column :text
      end
    end
  end
end
