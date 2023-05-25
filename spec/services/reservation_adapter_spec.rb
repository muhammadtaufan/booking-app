require 'rails_helper'

RSpec.describe ReservationAdapter, type: :model do
  describe '#for_partner' do
    context 'when reservation code is start with YYY' do
      it 'return Airbnb adapter' do
        params = { 'reservation_code' => 'YYY1234' }
        adapter = ReservationAdapter.for_partner(params)

        expect(adapter).to be_an_instance_of(AirbnbAdapter)
      end
    end

    context 'when reservation code is start with XXX' do
      it 'return Airbnb adapter' do
        params = { 'reservation' => { 'code' => 'XXX1234' } }
        adapter = ReservationAdapter.for_partner(params)

        expect(adapter).to be_an_instance_of(AirbncAdapter)
      end
    end

    context 'when reservation code is unknown format' do
      it 'return Airbnb adapter' do
        params = { 'booking_code' => 'YYY1234' }

        expect { ReservationAdapter.for_partner(params) }.to raise_error(ArgumentError)
      end
    end
  end
end
