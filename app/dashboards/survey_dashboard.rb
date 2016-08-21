require "administrate/base_dashboard"

class SurveyDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    survey_group: Field::BelongsTo,
    surveyable: Field::Polymorphic,
    surveys_questions: Field::HasMany,
    questions: Field::HasMany,
    id: Field::Number,
    completed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    last_updated_at: Field::DateTime,
    completed_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :survey_group,
    :surveyable,
    :surveys_questions,
    :questions,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :survey_group,
    :surveyable,
    :surveys_questions,
    :questions,
    :id,
    :completed,
    :created_at,
    :updated_at,
    :last_updated_at,
    :completed_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :survey_group,
    :surveyable,
    :surveys_questions,
    :questions,
    :completed,
    :last_updated_at,
    :completed_at,
  ].freeze

  # Overwrite this method to customize how surveys are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(survey)
  #   "Survey ##{survey.id}"
  # end
end
