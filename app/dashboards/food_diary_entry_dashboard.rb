require "administrate/base_dashboard"

class FoodDiaryEntryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    food_diary: Field::BelongsTo,
    id: Field::Number,
    consumed_at: Field::DateTime,
    food_item: Field::String,
    location: Field::String,
    note: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :food_diary,
    :id,
    :consumed_at,
    :food_item,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :food_diary,
    :id,
    :consumed_at,
    :food_item,
    :location,
    :note,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :food_diary,
    :consumed_at,
    :food_item,
    :location,
    :note,
  ].freeze

  # Overwrite this method to customize how food diary entries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(food_diary_entry)
  #   "FoodDiaryEntry ##{food_diary_entry.id}"
  # end
end
