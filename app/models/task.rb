class Task < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  include SoftDeletable

  def project 
    Project.unscoped{
      if super.is_deleted
        super.name = "-deleted-"
        super
      else
        super   
      end
    }
  end

  def employee 
    Employee.unscoped{
      if super.is_deleted 
        super.first_name = "-deleted-"
        super.last_name = ""
        super
      else
        super 
      end  
    }
  end

end
