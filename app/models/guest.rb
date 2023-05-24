class Guest < ApplicationRecord
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true
end
