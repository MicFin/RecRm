json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :member_plan_id, :user_id, :start_date, :end_date
  json.url subscription_url(subscription, format: :json)
end
