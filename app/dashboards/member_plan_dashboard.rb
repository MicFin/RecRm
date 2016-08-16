require "administrate/base_dashboard"

class MemberPlanDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    roles: Field::HasMany,
    subscriptions: Field::HasMany,
    users: Field::HasMany,
    plan: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    stripe_id: Field::String,
    amount: Field::Number,
    currency: Field::String,
    interval: Field::String,
    live_mode: Field::Boolean,
    interval_count: Field::Number,
    trial_period_days: Field::Number,
    statement_description: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :roles,
    :subscriptions,
    :users,
    :plan,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :roles,
    :subscriptions,
    :users,
    :plan,
    :id,
    :name,
    :created_at,
    :updated_at,
    :stripe_id,
    :amount,
    :currency,
    :interval,
    :live_mode,
    :interval_count,
    :trial_period_days,
    :statement_description,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :roles,
    :subscriptions,
    :users,
    :plan,
    :name,
    :stripe_id,
    :amount,
    :currency,
    :interval,
    :live_mode,
    :interval_count,
    :trial_period_days,
    :statement_description,
  ].freeze

  # Overwrite this method to customize how member plans are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(member_plan)
  #   "MemberPlan ##{member_plan.id}"
  # end
end
