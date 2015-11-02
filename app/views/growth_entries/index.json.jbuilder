json.array!(@growth_entries) do |growth_entry|
  json.extract! growth_entry, :id, :growth_chart_id, :entry_measured_at, :height_in_inches, :weight_in_ounces, :age
  json.url growth_entry_url(growth_entry, format: :json)
end
