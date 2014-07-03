ActiveAdmin.register Recipe do

filter :name
filter :dietitian_id
filter :created_at
filter :updated_at
filter :description
filter :inspiration
filter :avatar_file_name
filter :avatar_content_type
filter :avatar_file_size
filter :avatar_updated_at
filter :image_ur
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
