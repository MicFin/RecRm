require "administrate/base_dashboard"

class KfConfigDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    var: Field::String,
    value: Field::Text,
    thing_id: Field::Number,
    thing_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    display_name: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :var,
    :value,
    :thing_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :var,
    :value,
    :thing_id,
    :thing_type,
    :created_at,
    :updated_at,
    :display_name,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :var,
    :value,
    :thing_id,
    :thing_type,
    :display_name,
  ].freeze

  # Overwrite this method to customize how kf configs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(kf_config)
  #   "KfConfig ##{kf_config.id}"
  # end
end
