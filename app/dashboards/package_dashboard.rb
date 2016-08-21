require "administrate/base_dashboard"

class PackageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    purchases: Field::HasMany,
    user_packages: Field::HasMany,
    users: Field::HasMany,
    id: Field::Number,
    category: Field::String,
    name: Field::String,
    full_price: Field::Number,
    description: Field::Text,
    num_half_appointments: Field::Number,
    num_full_appointments: Field::Number,
    expiration_in_months: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :purchases,
    :user_packages,
    :users,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :purchases,
    :user_packages,
    :users,
    :id,
    :category,
    :name,
    :full_price,
    :description,
    :num_half_appointments,
    :num_full_appointments,
    :expiration_in_months,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :purchases,
    :user_packages,
    :users,
    :category,
    :name,
    :full_price,
    :description,
    :num_half_appointments,
    :num_full_appointments,
    :expiration_in_months,
  ].freeze

  # Overwrite this method to customize how packages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(package)
  #   "Package ##{package.id}"
  # end
end
