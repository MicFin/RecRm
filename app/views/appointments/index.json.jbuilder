json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :patient_focus_id, :appointment_host_id, :dietitian_id, :date, :room_id, :note, :client_note, :created_at, :updated_at
  json.url appointment_url(appointment, format: :json)
end
