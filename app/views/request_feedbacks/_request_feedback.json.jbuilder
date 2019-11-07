json.extract! request_feedback, :id, :rating, :comment, :created_at, :updated_at
json.url request_feedback_url(request_feedback, format: :json)
