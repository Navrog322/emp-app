class Task < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  validates :name, presence: true
  validates :body, presence: true
  validates :employee_id, presence: true
  validates :project_id, presence: true

  paginates_per 10
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
