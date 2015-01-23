json.array!(@appointments) do |appointment|
  json.extract! appointment, :id
  json.start appointment.start_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.end appointment.end_time.in_time_zone("Eastern Time (US & Canada)").strftime("%B %d, %Y %I:%M %p")
  json.description appointment.dietitian.email
end
