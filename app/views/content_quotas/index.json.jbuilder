json.array!(@content_quotas) do |content_quota|
  json.extract! content_quota, :id
  json.url content_quota_url(content_quota, format: :json)
end
