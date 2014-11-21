json.array!(@member_plans) do |member_plan|
  json.extract! member_plan, :id, :name
  json.url member_plan_url(member_plan, format: :json)
end
