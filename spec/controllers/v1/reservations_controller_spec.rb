require 'rails_helper'

RSpec.describe V1::ReservationsController, type: :controller do
  describe 'POST #create_reservation' do
    context 'when the reservation params is valid' do
      it 'returns a success response and create a new reservation and a new guest' do
        valid_params = {
          "reservation_code": 'YYY12345678',
          "start_date": '2021-04-14',
          "end_date": '2021-04-18',
          "nights": 10,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": 'canceled',
          "guest": {
            "first_name": 'Wayne',
            "last_name": 'Woodbridge',
            "phone": '639123456789',
            "email": 'wayne_woodbridge@bnb.com'
          },
          "currency": 'AUD',
          "payout_price": '4200.00',
          "security_price": '500',
          "total_price": '4700.00'
        }
        post :create_reservation, params: valid_params

        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)['success']).to eq(true)

        reservation = Reservation.last
        expect(reservation.reservation_code).to eq(valid_params[:reservation_code])

        guest = Guest.last
        expect(guest.email).to eq(valid_params[:guest][:email])
      end
    end

    context 'when the reservation params is invalid' do
      it 'returns a bad request' do
        post :create_reservation, params: { reservation: { code: 'AAA123' } }

        expect(response.status).to eq(422)
      end
    end
  end
end
