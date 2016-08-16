require "administrate/base_dashboard"

class PostRecommendationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    dietitian: Field::BelongsTo,
    user: Field::BelongsTo,
    monologue_post: Field::BelongsTo.with_options(class_name: "Monologue::Post"),
    appointment: Field::BelongsTo,
    id: Field::Number,
    message: Field::Text,
    monologue_post_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :dietitian,
    :user,
    :monologue_post,
    :appointment,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :dietitian,
    :user,
    :monologue_post,
    :appointment,
    :id,
    :message,
    :monologue_post_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :dietitian,
    :user,
    :monologue_post,
    :appointment,
    :message,
    :monologue_post_id,
  ].freeze

  # Overwrite this method to customize how post recommendations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(post_recommendation)
  #   "PostRecommendation ##{post_recommendation.id}"
  # end
end
