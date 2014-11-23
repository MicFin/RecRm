json.array!(@plans) do |plan|
  json.extract! plan, :id, :def, :appointment_params
  json.url plan_url(plan, format: :json)
end
