ActiveAdmin.register PatientGroup do

  filter :name 
  filter :category
  filter :description
  filter :order
  filter :input_option  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :category, :description, :input_option, :order, :has_triggers
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
