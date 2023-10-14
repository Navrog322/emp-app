json.extract! task, :id, :name, :body, :is_completed, :project_id, :employee_id, :created_at, :updated_at
json.url task_url(task, format: :json)
