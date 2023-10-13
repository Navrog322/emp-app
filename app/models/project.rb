class Project < ApplicationRecord
  belongs_to :language
  belongs_to :supervisor, class_name: "Employee"

  include SoftDeletable

  validates :name, presence: true
  validates :body, presence: true
  validates :language_id, presence: true

  def supervisor
    Employee.unscoped{
      if(super.is_deleted == true) 
        super.first_name = "-deleted-"
        super.last_name = ""
        super
      else 
        return super
      end
    }
  end
end
