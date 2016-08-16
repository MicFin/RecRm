require "administrate/base_dashboard"

class TimeSlotDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    availability: Field::BelongsTo,
    dietitian: Field::HasOne,
    appointment: Field::HasOne,
    id: Field::Number,
    title: Field::String,
    start_time: Field::DateTime,
    end_time: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    minutes: Field::Number,
    status: Field::String,
    vacancy: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :availability,
    :dietitian,
    :appointment,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :availability,
    :dietitian,
    :appointment,
    :id,
    :title,
    :start_time,
    :end_time,
    :created_at,
    :updated_at,
    :minutes,
    :status,
    :vacancy,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :availability,
    :dietitian,
    :appointment,
    :title,
    :start_time,
    :end_time,
    :minutes,
    :status,
    :vacancy,
  ].freeze

  # Overwrite this method to customize how time slots are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(time_slot)
  #   "TimeSlot ##{time_slot.id}"
  # end
end
