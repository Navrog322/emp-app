class Position < ApplicationRecord
  has_many :employees

  include SoftDeletable

  validates :name, presence: true, uniqueness: true
  validates :super, inclusion: { in: [ true, false ] }
end
