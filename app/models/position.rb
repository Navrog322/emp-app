class Position < ApplicationRecord
  has_many :employees
  validates :name, presence: true
  validates :super, inclusion: { in: [ true, false ] }
end
