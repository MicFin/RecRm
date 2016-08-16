require "administrate/base_dashboard"

class QuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    survey_group: Field::BelongsTo,
    surveys_questions: Field::HasMany,
    surveys: Field::HasMany,
    id: Field::Number,
    question_type: Field::String,
    content: Field::Text,
    position: Field::Number,
    tier: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :survey_group,
    :surveys_questions,
    :surveys,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :survey_group,
    :surveys_questions,
    :surveys,
    :id,
    :question_type,
    :content,
    :position,
    :tier,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :survey_group,
    :surveys_questions,
    :surveys,
    :question_type,
    :content,
    :position,
    :tier,
  ].freeze

  # Overwrite this method to customize how questions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(question)
  #   "Question ##{question.id}"
  # end
end
