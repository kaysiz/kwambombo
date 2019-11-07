json.extract! clean_request, :id, :status, :created_at, :updated_at
json.url clean_request_url(clean_request, format: :json)
