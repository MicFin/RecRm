json.array!(@images) do |image|
  json.extract! image, :id, :type
  json.url image_url(image, format: :json)
end
