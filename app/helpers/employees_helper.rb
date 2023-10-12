module EmployeesHelper
  def full_name emp 
    emp.first_name + " " + emp.last_name
  end
end
