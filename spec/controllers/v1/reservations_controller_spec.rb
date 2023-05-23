require 'rails_helper'

RSpec.describe V1::ReservationsController, type: :controller do
  describe 'POST #create_reservation' do
    context 'when the reservation is valid' do
      it 'returns a success response' do
        post :create_reservation, params: { reservation_code: 'YYY123' }

        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)['data']['partner']).to eq('Airbnb')
      end
    end

    context 'when the reservation is invalid' do
      it 'returns a bad request' do
        post :create_reservation, params: { reservation: { code: 'AAA123' } }

        expect(response.status).to eq(400)
      end
    end
  end
end
