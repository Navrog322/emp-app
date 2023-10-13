class Language < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
