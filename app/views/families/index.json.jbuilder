json.array!(@families) do |family|
  json.extract! family, :id, :name, :location, :head_of_family_id, :created_at, :updated_at
  json.url family_url(family, format: :json)
end
