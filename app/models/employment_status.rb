class EmploymentStatus < ApplicationRecord
  has_many :employees

  include SoftDeletable

  validates :name, presence: true
end
