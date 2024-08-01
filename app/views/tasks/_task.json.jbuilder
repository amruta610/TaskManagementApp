json.extract! task, :id, :name, :category, :priority, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
