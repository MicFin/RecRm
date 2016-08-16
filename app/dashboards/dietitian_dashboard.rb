require "administrate/base_dashboard"

class DietitianDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    roles: Field::HasMany,
    appointments: Field::HasMany,
    availabilities: Field::HasMany,
    time_slots: Field::HasMany,
    post_recommendations: Field::HasMany,
    images: Field::HasMany,
    expertises: Field::HasMany,
    patient_groups: Field::HasMany,
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    first_name: Field::String,
    last_name: Field::String,
    signature: Field::String,
    time_zone: Field::String,
    location: Field::String,
    experience_level: Field::Number,
    age_level: Field::Number,
    undergraduate_education: Field::String,
    graduate_education: Field::String,
    professional_experience_first: Field::String,
    professional_experience_second: Field::String,
    professional_experience_third: Field::String,
    professional_experience_fourth: Field::String,
    professional_experience_fifth: Field::String,
    introduction: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :roles,
    :appointments,
    :availabilities,
    :time_slots,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :roles,
    :appointments,
    :availabilities,
    :time_slots,
    :post_recommendations,
    :images,
    :expertises,
    :patient_groups,
    :id,
    :email,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :created_at,
    :updated_at,
    :first_name,
    :last_name,
    :signature,
    :time_zone,
    :location,
    :experience_level,
    :age_level,
    :undergraduate_education,
    :graduate_education,
    :professional_experience_first,
    :professional_experience_second,
    :professional_experience_third,
    :professional_experience_fourth,
    :professional_experience_fifth,
    :introduction,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :roles,
    :appointments,
    :availabilities,
    :time_slots,
    :post_recommendations,
    :images,
    :expertises,
    :patient_groups,
    :email,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :first_name,
    :last_name,
    :signature,
    :time_zone,
    :location,
    :experience_level,
    :age_level,
    :undergraduate_education,
    :graduate_education,
    :professional_experience_first,
    :professional_experience_second,
    :professional_experience_third,
    :professional_experience_fourth,
    :professional_experience_fifth,
    :introduction,
  ].freeze

  # Overwrite this method to customize how dietitians are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(dietitian)
  #   "Dietitian ##{dietitian.id}"
  # end
end
