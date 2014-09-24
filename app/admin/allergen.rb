ActiveAdmin.register Allergen do


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
  index do
    column "Name" do |allergen|
      link_to allergen.name, admin_allergen_path(allergen.id)
    end
    column :description
    column :manual_enter
    column :top_allergen   
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :description
  filter :manual_enter
  filter :top_allergen   
  filter :created_at
  filter :updated_at
  permit_params :name, :description
end
