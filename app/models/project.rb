class Project < ApplicationRecord
  belongs_to :language
  belongs_to :supervisor, class_name: "Employee"

  include SoftDeletable

  validates :name, presence: true
  validates :body, presence: true
  validates :language_id, presence: true


end
