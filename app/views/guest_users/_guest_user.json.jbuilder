json.extract! guest_user, :id, :first_name, :last_name, :phone_number, :email_address, :title, :company, :purpose, :help, :created_at, :updated_at
json.url guest_user_url(guest_user, format: :json)