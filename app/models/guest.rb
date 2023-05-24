class Guest < ApplicationRecord
  validates :email, uniqueness: true

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :phone, presence: true

  has_many :reservations
end
