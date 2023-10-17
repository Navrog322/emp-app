class Employee < ApplicationRecord

  paginates_per 10

  belongs_to :position
  belongs_to :superior, class_name: "Employee", optional:true
  has_many :subordinates, class_name: "Employee", foreign_key:"superior_id"
  belongs_to :employment_status
  has_many :projects_under_supervision, class_name:"Project", foreign_key:"supervisor_id"
  has_many :tasks
  has_many :projects, through: :tasks

  
  include SoftDeletable

  validates :JMBG, presence: true, uniqueness: true, format: { with: /\d{13}/,
  message: "needs to have 13 numbers" }
  

  validates :first_name, presence: true, length: { in: 2..20 }
  validates :last_name, presence: true, length: { in: 2..20 }
  #validates_format_of :first_name, :last_name, with: /\A[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: 
            { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\z/, 
             message: "Invalid format" }

  validates :address, presence: true, length: { in: 5..80 }
  validates :position_id, presence: true
  validates :employment_status_id, presence: true
  validates :employment_date, presence: true

  validate :superior_id_must_correspond_to_valid_employee
  validate :position_id_must_correspond_to_valid_position
  validate :employment_status_id_must_correspond_to_valid_employment_status
  validate :validate_jmbg

  def date_must_be_in_the_past
    if employment_date.present? && employment_date > Date.today
      errors.add(:employment_date, "can't be in the future")
    end
  end

  def superior_id_must_correspond_to_valid_employee
    if superior_id.present? && !Employee.exists?(superior_id)
      errors.add(:superior_id, "invalid superior id")
    end
  end

  def position_id_must_correspond_to_valid_position
    if position_id.present? && !Position.exists?(position_id)
      errors.add(:position_id, "invalid position id")
    end
  end

  def employment_status_id_must_correspond_to_valid_employment_status
    if employment_status_id.present? && !EmploymentStatus.exists?(employment_status_id)
      errors.add(:employment_status_id, "invalid employment status id")
    end
  end

  def position
    Position.unscoped{
      if(!super.nil? && super.is_deleted == true) 
        super.name+= " (deleted)"
        super
      else 
        return super
      end
    }
  end

  def employment_status
    EmploymentStatus.unscoped{
      if(!super.nil? && super.is_deleted == true) 
        super.name += " (deleted)"
        super
      else 
        return super
      end
    }
  end

  def superior
    Employee.unscoped{
      if(!super.nil? && super.is_deleted == true) 
        super.last_name += " (deleted)"
        super
      else 
        return super
      end
    }
  end

  def validate_jmbg
    if self.JMBG.length != 13
      self.errors.add(:JMBG, "must be valid")
      return false 
    end
    day = self.JMBG[0..1].to_i
    month = self.JMBG[2..3].to_i
    year = self.JMBG[4..6].to_i
    unless Date.valid_date?(year, month, day)
      self.errors.add(:JMBG, "must be valid")
      return false
    end
    arr = self.JMBG.split("").map(&:to_i)
    sum = 0
    6.times do |i|
      sum += (7-i)*(arr[i]+arr[6+i])
    end
    control_digit = 11 - ((sum)%11)
    control_digit = 0 if control_digit == 11 || control_digit == 10
    self.errors.add(:JMBG, "must be valid") unless control_digit == arr[12]  
  end          
  

  private
  def handle_superior_destruction
    if !self.subordinates.empty?
      self.subordinates.each do |e|
        e.superior_id=nil
        e.save
      end
    end

    

  end
  
  
end
