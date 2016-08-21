require "administrate/base_dashboard"

class SubscriptionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    member_plan: Field::BelongsTo,
    user: Field::BelongsTo,
    id: Field::Number,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    trial_end: Field::DateTime,
    trial_start: Field::DateTime,
    ended_at: Field::DateTime,
    current_period_start: Field::DateTime,
    current_period_end: Field::DateTime,
    cancelled_at: Field::DateTime,
    status: Field::String,
    quantity: Field::Number,
    stripe_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :member_plan,
    :user,
    :id,
    :start_date,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :member_plan,
    :user,
    :id,
    :start_date,
    :end_date,
    :type,
    :created_at,
    :updated_at,
    :trial_end,
    :trial_start,
    :ended_at,
    :current_period_start,
    :current_period_end,
    :cancelled_at,
    :status,
    :quantity,
    :stripe_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :member_plan,
    :user,
    :start_date,
    :end_date,
    :type,
    :trial_end,
    :trial_start,
    :ended_at,
    :current_period_start,
    :current_period_end,
    :cancelled_at,
    :status,
    :quantity,
    :stripe_id,
  ].freeze

  # Overwrite this method to customize how subscriptions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(subscription)
  #   "Subscription ##{subscription.id}"
  # end
end
