json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :taste, :cook_time, :prep_time, :difficulty, :course, :age_group, :target_group, :dietitian_id
  json.url recipe_url(recipe, format: :json)
end
