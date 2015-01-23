json.array!(@availabilities) do |availability|
  json.extract! availability, :id

  json.start availability.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.end availability.end_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
	json.buffered_start availability.buffered_start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.buffered_end availability.buffered_end_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.status availability.status
  json.url availability_url(availability, format: :json)
end
