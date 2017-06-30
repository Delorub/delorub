ActiveAdmin.register Certificate do
  permit_params :file, :profile_id

  controller do
    def scoped_collection
      end_of_association_chain.where.not(profile_id: nil)
    end
  end

  form do |f|
    inputs 'Основное' do
      input :file
      input :profile
    end
    actions
  end

  index do
    selectable_column
    column :preview do |certificate|
      image_tag certificate.file.preview.url
    end
    column :profile do |certificate|
      link_to certificate.profile.name, admin_profile_path(certificate.profile)
    end
    actions
  end

  show do
    attributes_table_for certificate do
      row :thumb do |certificate|
        image_tag certificate.file.thumb.url
      end
      row :profile do |certificate|
        link_to certificate.profile.name, admin_profile_path(certificate.profile)
      end
    end
  end
end
