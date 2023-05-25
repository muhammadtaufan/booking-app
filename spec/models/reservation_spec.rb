require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject { create(:reservation) }

  it { should validate_uniqueness_of(:reservation_code) }
end
