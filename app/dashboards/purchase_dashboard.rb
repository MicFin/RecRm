require "administrate/base_dashboard"

class PurchaseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    coupon_redemption: Field::HasOne,
    coupon: Field::HasOne,
    purchasable: Field::Polymorphic,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    stripe_card_token: Field::String,
    invoice_price: Field::Number,
    invoice_cost: Field::Number,
    status: Field::String,
    completed_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    # :coupon_redemption,
    :coupon,
    :purchasable,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    # :coupon_redemption,
    :coupon,
    :purchasable,
    :id,
    :created_at,
    :updated_at,
    :stripe_card_token,
    :invoice_price,
    :invoice_cost,
    :status,
    :completed_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :coupon_redemption,
    :coupon,
    :purchasable,
    :stripe_card_token,
    :invoice_price,
    :invoice_cost,
    :status,
    :completed_at,
  ].freeze

  # Overwrite this method to customize how purchases are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(purchase)
  #   "Purchase ##{purchase.id}"
  # end
end
