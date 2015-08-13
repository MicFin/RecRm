json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :code, :description, :valid_from, :valid_until, :redemption_limit, :redemptions_count, :amount, :type, :status
  json.url coupon_url(coupon, format: :json)
end
