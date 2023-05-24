class Reservation < ApplicationRecord
  belongs_to :guest

  validates :reservation_code, uniqueness: true
end
