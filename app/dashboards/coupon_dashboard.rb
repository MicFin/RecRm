require "administrate/base_dashboard"

class CouponDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    coupon_redemptions: Field::HasMany,
    purchases: Field::HasMany,
    users: Field::HasMany,
    id: Field::Number,
    code: Field::String,
    description: Field::String,
    valid_from: Field::DateTime,
    valid_until: Field::DateTime,
    redemption_limit: Field::Number,
    redemptions_count: Field::Number,
    amount: Field::Number,
    amount_type: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    redemption_limit_per_user: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :coupon_redemptions,
    :purchases,
    :users,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :coupon_redemptions,
    :purchases,
    :users,
    :id,
    :code,
    :description,
    :valid_from,
    :valid_until,
    :redemption_limit,
    :redemptions_count,
    :amount,
    :amount_type,
    :status,
    :created_at,
    :updated_at,
    :redemption_limit_per_user,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :coupon_redemptions,
    :purchases,
    :users,
    :code,
    :description,
    :valid_from,
    :valid_until,
    :redemption_limit,
    :redemptions_count,
    :amount,
    :amount_type,
    :status,
    :redemption_limit_per_user,
  ].freeze

  # Overwrite this method to customize how coupons are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(coupon)
  #   "Coupon ##{coupon.id}"
  # end
end
