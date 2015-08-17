json.array!(@packages) do |package|
  json.extract! package, :id, :category, :name, :full_price, :description, :num_half_appointments, :num_full_appointments, :expiration_in_months
  json.url package_url(package, format: :json)
end
