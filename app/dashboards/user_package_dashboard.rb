require "administrate/base_dashboard"

class UserPackageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    package: Field::BelongsTo,
    purchase: Field::HasOne,
    id: Field::Number,
    purchase_date: Field::DateTime,
    expiration_date: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :package,
    :purchase,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :package,
    :purchase,
    :id,
    :purchase_date,
    :expiration_date,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :package,
    :purchase,
    :purchase_date,
    :expiration_date,
  ].freeze

  # Overwrite this method to customize how user packages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user_package)
  #   "UserPackage ##{user_package.id}"
  # end
end
