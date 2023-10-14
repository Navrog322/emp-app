class EmploymentStatus < ApplicationRecord
  has_many :employees

  include SoftDeletable

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
end
