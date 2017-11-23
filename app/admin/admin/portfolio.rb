ActiveAdmin.register Portfolio do
  permit_params :cover, :profile_id

  form do |f|
    inputs 'Основное' do
      input :cover
      input :profile
    end
    actions
  end

  index do
    selectable_column
    column :preview do |item|
      image_tag item.cover.medium.url
    end
    column :profile do |item|
      link_to item.profile.user.decorate.name, admin_profile_path(item.profile)
    end
    actions
  end

  show do
    attributes_table_for portfolio do
      row :profile do |item|
        link_to item.profile.user.decorate.name, admin_profile_path(item.profile)
      end
      row :preview do |item|
        image_tag item.cover.preview.url
      end
    end
  end
end
