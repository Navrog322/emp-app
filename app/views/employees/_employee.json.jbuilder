json.extract! employee, :id, :JMBG, :first_name, :last_name, :email, :address, :position_id, :employment_date, :superior_id, :employment_status_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
