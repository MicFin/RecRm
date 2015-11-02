json.array!(@food_diaries) do |food_diary|
  json.extract! food_diary, :id, :user_id
  json.url food_diary_url(food_diary, format: :json)
end
