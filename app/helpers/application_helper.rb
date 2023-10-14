module ApplicationHelper
  def full_name e 
    e.first_name + " " + e.last_name
  end
  def yes_or_no b
    b ? "Yes" : "No"
  end
end
