class Project < ApplicationRecord

  paginates_per 10
  
  belongs_to :language
  belongs_to :supervisor, class_name: "Employee"
  has_many :tasks

  include SoftDeletable

  validates :name, presence: true
  validates :body, presence: true
  validates :language_id, presence: true
  validates :supervisor_id, presence: true

  validate :language_id_must_correspond_to_valid_language
  validate :supervisor_id_must_correspond_to_valid_employee

  def supervisor_id_must_correspond_to_valid_employee
    if supervisor_id.present? && !Employee.exists?(supervisor_id)
      errors.add(:supervisor_id, "invalid id")
    end
  end

  def language_id_must_correspond_to_valid_language
    if language_id.present? && !Language.exists?(language_id)
      errors.add(:language_id, "invalid id")
    end
  end

  def supervisor
    Employee.unscoped{
      if(!super.nil? && super.is_deleted == true) 
        super.first_name = "-deleted-"
        super.last_name = ""
        super
      else 
        return super
      end
    }
  end
end
