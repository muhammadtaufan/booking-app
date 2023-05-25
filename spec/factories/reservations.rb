FactoryBot.define do
  factory :reservation do
    reservation_code { 'XXX12345678' }
    start_date { Date.today }
    end_date { Date.today + 7.days }
    night_count { 7 }
    guest_count { 2 }
    status { 'accepted' }
    currency { 'USD' }
    payout_price { '1000.00' }
    security_price { '100.00' }
    total_price { '1100.00' }

    association :guest
  end
end
