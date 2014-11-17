json.array!(@time_slots) do |time_slot|
  json.extract! time_slot, :id, :title
  json.start time_slot.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.end time_slot.end_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.url time_slot_url(time_slot, format: :json)
end