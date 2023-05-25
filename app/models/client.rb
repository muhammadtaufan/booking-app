class Client < ApplicationRecord
  validates :name, :secret, presence: true
end
