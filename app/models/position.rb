class Position < ApplicationRecord
  has_many :employees

  include SoftDeletable

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }, 
            format: {with: /\A[a-z]+\z/i, message: "must contain only letters"}
  validates :super, inclusion: { in: [ true, false ] }
end
