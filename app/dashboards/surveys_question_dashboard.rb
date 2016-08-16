require "administrate/base_dashboard"

class SurveysQuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    survey: Field::BelongsTo,
    question: Field::BelongsTo,
    id: Field::Number,
    answer: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :survey,
    :question,
    :id,
    :answer,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :survey,
    :question,
    :id,
    :answer,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :survey,
    :question,
    :answer,
  ].freeze

  # Overwrite this method to customize how surveys questions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(surveys_question)
  #   "SurveysQuestion ##{surveys_question.id}"
  # end
end
