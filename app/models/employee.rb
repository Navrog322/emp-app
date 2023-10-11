class Employee < ApplicationRecord
  belongs_to :position
  belongs_to :superior, class_name: "Employee", optional:true
  has_many :subordinates, class_name: "Employee", foreign_key:"superior_id"
  belongs_to :employment_status
end
