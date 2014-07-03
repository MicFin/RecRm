ActiveAdmin.register Dietitian do

  
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
  # endfilter :email


  permit_params :email, :password, :password_confirmation

    filter :email
    filter :encrypted_password   
    filter :reset_password_token
    filter :reset_password_sent_at
    filter :remember_created_at
    filter :sign_in_count       
    filter :current_sign_in_at
    filter :last_sign_in_at
    filter :current_sign_in_ip
    filter :last_sign_in_ip
    filter :created_at
    filter :updated_at

      form do |f|
        f.inputs "Dietitian Details" do
          f.input :email
          f.input :password
          f.input :password_confirmation
        end
        f.actions
      end
end
