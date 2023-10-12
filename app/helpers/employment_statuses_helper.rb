module EmploymentStatusesHelper
  def deletable? status
    status.employees.empty?
  end
end
