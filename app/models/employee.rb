class Employee < ApplicationRecord
  belongs_to :position
  belongs_to :superior, class_name: "Employee", optional:true
  has_many :subordinates, class_name: "Employee", foreign_key:"superior_id"
  belongs_to :employment_status
  before_destroy :handle_superior_destruction

  validates :JMBG, presence: true, format: { with: /\d{13}/,
  message: "needs to have 13 numbers" }

  validates :first_name, presence: true, length: { in: 2..20 }
  validates :last_name, presence: true, length: { in: 2..20 }

  validates :email, presence: true, uniqueness: true#, format: { with: /\A[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}\z/, message: "Invalid email format" }

  validates :address, presence: true, length: { in: 5..80 }
  validates :position_id, presence: true
  validates :employment_date, presence: true
  validate :date_must_be_in_the_past
  validate :superior_id_must_correspond_to_valid_employee
  validate :position_id_must_correspond_to_valid_position
  validate :employment_status_id_must_correspond_to_valid_employment_status

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
