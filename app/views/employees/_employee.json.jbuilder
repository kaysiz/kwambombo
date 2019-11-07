json.extract! employee, :id, :full_name, :status, :role, :created_at, :updated_at
json.url employee_url(employee, format: :json)
