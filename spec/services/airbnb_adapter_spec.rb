require 'rails_helper'

RSpec.describe AirbnbAdapter, type: :model do
  let(:payload) do
    {
      'guest' => {
        'first_name' => 'John',
        'last_name' => 'Doe',
        'phone' => '1234567890',
        'email' => 'john.doe@example.com'
      },
      'reservation_code' => 'YYY12345678',
      'start_date' => '2023-12-01',
      'end_date' => '2023-12-05',
      'nights' => 4,
      'guests' => 2,
      'adults' => 2,
      'children' => 0,
      'infants' => 0,
      'status' => 'accepted',
      'currency' => 'USD',
      'payout_price' => '1000.00',
      'security_price' => '100.00',
      'total_price' => '1100.00'
    }
  end
  let(:adapter) { AirbnbAdapter.new(payload) }

  describe '#parse' do
    context 'when payload is valid' do
      it 'return valid guest and reservation params' do
        params = adapter.parse

        expect(params[:guest_params]).to eq({
                                              firstname: 'John',
                                              lastname: 'Doe',
                                              phone: '1234567890',
                                              email: 'john.doe@example.com'
                                            })

        expect(params[:reservation_params]).to eq({
                                                    reservation_code: 'YYY12345678',
                                                    start_date: Date.parse('2023-12-01'),
                                                    end_date: Date.parse('2023-12-05'),
                                                    night_count: 4,
                                                    guest_count: 2,
                                                    children_count: 0,
                                                    infant_count: 0,
                                                    adult_count: 2,
                                                    status: 'accepted',
                                                    currency: 'USD',
                                                    payout_price: '1000.00',
                                                    security_price: '100.00',
                                                    total_price: '1100.00'
                                                  })
      end
    end

    context 'when payload is missing optional data' do
      before do
        payload['guest'].delete('phone')
        payload.delete('infants')
      end

      it 'assigns default values to missing data' do
        result = adapter.parse

        expect(result[:guest_params][:phone]).to eq(nil)
        expect(result[:reservation_params][:infant_count]).to eq(nil)
      end
    end
  end
end
