require "administrate/base_dashboard"

class AppointmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    appointment_host: Field::BelongsTo.with_options(class_name: "User"),
    patient_focus: Field::BelongsTo.with_options(class_name: "User"),
    dietitian: Field::BelongsTo,
    room: Field::BelongsTo,
    time_slot: Field::BelongsTo,
    surveys: Field::HasMany,
    purchase: Field::HasOne,
    post_recommendations: Field::HasMany,
    monologue_posts: Field::HasMany.with_options(class_name: "Monologue::Post"),
    id: Field::Number,
    patient_focus_id: Field::Number,
    appointment_host_id: Field::Number,
    note: Field::Text,
    client_note: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    start_time: Field::DateTime,
    end_time: Field::DateTime,
    stripe_card_token: Field::String,
    regular_price: Field::Number,
    invoice_price: Field::Number,
    duration: Field::Number,
    other_note: Field::Text,
    status: Field::String,
    registration_stage: Field::Number,
    client_assessment_sent: Field::Boolean,
    client_assessment_sent_at: Field::DateTime,
    provider_assessment_sent: Field::Boolean,
    provider_assessment_sent_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :appointment_host,
    :patient_focus,
    :dietitian,
    :room,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :appointment_host,
    :patient_focus,
    :dietitian,
    :room,
    # :time_slot,
    :surveys,
    :purchase,
    :post_recommendations,
    :monologue_posts,
    :id,
    :patient_focus_id,
    :appointment_host_id,
    :note,
    :client_note,
    :created_at,
    :updated_at,
    :start_time,
    :end_time,
    :stripe_card_token,
    :regular_price,
    :invoice_price,
    :duration,
    :other_note,
    :status,
    :registration_stage,
    :client_assessment_sent,
    :client_assessment_sent_at,
    :provider_assessment_sent,
    :provider_assessment_sent_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :appointment_host,
    :patient_focus,
    :dietitian,
    :room,
    :time_slot,
    :surveys,
    :purchase,
    :post_recommendations,
    :monologue_posts,
    :patient_focus_id,
    :appointment_host_id,
    :note,
    :client_note,
    :start_time,
    :end_time,
    :stripe_card_token,
    :regular_price,
    :invoice_price,
    :duration,
    :other_note,
    :status,
    :registration_stage,
    :client_assessment_sent,
    :client_assessment_sent_at,
    :provider_assessment_sent,
    :provider_assessment_sent_at,
  ].freeze

  # Overwrite this method to customize how appointments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(appointment)
  #   "Appointment ##{appointment.id}"
  # end
end
