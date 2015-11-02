json.array!(@food_diary_entries) do |food_diary_entry|
  json.extract! food_diary_entry, :id, :food_diary_id, :consumed_at, :food_item, :location, :note
  json.url food_diary_entry_url(food_diary_entry, format: :json)
end
