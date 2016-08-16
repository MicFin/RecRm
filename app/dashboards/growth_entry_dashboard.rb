require "administrate/base_dashboard"

class GrowthEntryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    growth_chart: Field::BelongsTo,
    id: Field::Number,
    measured_at: Field::DateTime,
    height_in_inches: Field::Number,
    weight_in_ounces: Field::Number,
    age: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    height_percentile: Field::String,
    height_z_score: Field::String,
    weight_percentile: Field::String,
    weight_z_score: Field::String,
    bmi_percentile: Field::String,
    bmi_z_score: Field::String,
    dietitian_note: Field::Text,
    client_note: Field::Text,
    energy_requirement: Field::String,
    protein_requirement: Field::String,
    fluids_requirement: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :growth_chart,
    :id,
    :measured_at,
    :height_in_inches,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :growth_chart,
    :id,
    :measured_at,
    :height_in_inches,
    :weight_in_ounces,
    :age,
    :created_at,
    :updated_at,
    :height_percentile,
    :height_z_score,
    :weight_percentile,
    :weight_z_score,
    :bmi_percentile,
    :bmi_z_score,
    :dietitian_note,
    :client_note,
    :energy_requirement,
    :protein_requirement,
    :fluids_requirement,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :growth_chart,
    :measured_at,
    :height_in_inches,
    :weight_in_ounces,
    :age,
    :height_percentile,
    :height_z_score,
    :weight_percentile,
    :weight_z_score,
    :bmi_percentile,
    :bmi_z_score,
    :dietitian_note,
    :client_note,
    :energy_requirement,
    :protein_requirement,
    :fluids_requirement,
  ].freeze

  # Overwrite this method to customize how growth entries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(growth_entry)
  #   "GrowthEntry ##{growth_entry.id}"
  # end
end
