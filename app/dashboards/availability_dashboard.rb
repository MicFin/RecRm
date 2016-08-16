require "administrate/base_dashboard"

class AvailabilityDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    dietitian: Field::BelongsTo,
    time_slots: Field::HasMany,
    id: Field::Number,
    start_time: Field::DateTime,
    end_time: Field::DateTime,
    buffered_start_time: Field::DateTime,
    buffered_end_time: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    status: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :dietitian,
    :time_slots,
    :id,
    :start_time,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :dietitian,
    :time_slots,
    :id,
    :start_time,
    :end_time,
    :buffered_start_time,
    :buffered_end_time,
    :created_at,
    :updated_at,
    :status,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :dietitian,
    :time_slots,
    :start_time,
    :end_time,
    :buffered_start_time,
    :buffered_end_time,
    :status,
  ].freeze

  # Overwrite this method to customize how availabilities are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(availability)
  #   "Availability ##{availability.id}"
  # end
end
