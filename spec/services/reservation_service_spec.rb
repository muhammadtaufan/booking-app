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
  let(:guest) do
    instance_double(Guest, valid?: true, assign_attributes: true, save: true, save!: true)
  end
  let(:new_record_reservation) do
    instance_double(Reservation, valid?: true, assign_attributes: true, save: true, save!: true,
                                 new_record?: true).tap do |reservation|
      allow(reservation).to receive(:guest=).with(guest)
    end
  end

  let(:existing_record_reservation) do
    instance_double(Reservation, valid?: true, assign_attributes: true, save!: false,
                                 new_record?: false, reservation_code: 'YYY12345678').tap do |reservation|
      allow(reservation).to receive(:guest=).with(guest)
    end
  end

  describe '#create_reservation' do
    context 'with a new reservation' do
      before do
        allow(Guest).to receive(:find_or_initialize_by).and_return(guest)
        allow(Reservation).to receive(:find_or_initialize_by).and_return(new_record_reservation)
      end

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

    context 'with existing reservation code' do
      before do
        allow(Guest).to receive(:find_or_initialize_by).and_return(guest)
        allow(Reservation).to receive(:find_or_initialize_by).and_return(existing_record_reservation)
      end

      it 'return false and raise an exception' do
        expect do
          service.create_new_reservation
        end.to raise_error(ReservationAlreadyExists,
                           'Reservation with code YYY12345678 already exists')
      end
    end
  end
end
