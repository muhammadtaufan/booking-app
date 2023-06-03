require 'rails_helper'

RSpec.describe ReservationService, type: :service do
  let(:guest_params) do
    {
      firstname: 'Wayne',
      lastname: 'Woodbridge',
      phone: '639123456789',
      email: 'wayne_woodbridge@bnb.com'
    }
  end
  let(:reservation_params) do
    {
      reservation_code: 'YYY12345678',
      start_date: 'Wed, 14 Apr 2021',
      end_date: 'Sun, 18 Apr 2021',
      night_count: 10,
      guest_count: 4,
      children_count: 2,
      infant_count: 0,
      adult_count: 2,
      status: 'canceled',
      currency: 'AUD',
      payout_price: '4200.00',
      security_price: '500',
      total_price: '4700.00'
    }
  end
  let(:valid_params) do
    {
      guest_params: guest_params,
      reservation_params: reservation_params
    }
  end

  let(:service) { described_class.new(valid_params) }
  let(:guest) { instance_double(Guest, valid?: true, assign_attributes: true, save: true) }
  let(:reservation) { instance_double(Reservation, valid?: true, assign_attributes: true, save: true) }

  before do
    allow(Guest).to receive(:find_or_initialize_by).and_return(guest)
    allow(Reservation).to receive(:find_or_initialize_by).and_return(reservation)
  end

  describe '#create_reservation' do
    context 'with valid params' do
      it 'return true and create a new reservation' do
        expect(service.create_new_reservation).to be_truthy
      end
    end

    context 'when parameters are invalid' do
      before do
        allow(guest).to receive(:valid?).and_return(false)
      end

      it 'does not create a new reservation' do
        expect(service.create_new_reservation).to be_nil
      end
    end
  end
end
