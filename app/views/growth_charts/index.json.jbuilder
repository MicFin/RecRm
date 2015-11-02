json.array!(@growth_charts) do |growth_chart|
  json.extract! growth_chart, :id, :user_id
  json.url growth_chart_url(growth_chart, format: :json)
end
