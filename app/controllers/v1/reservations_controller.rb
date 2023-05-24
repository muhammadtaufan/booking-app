# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    def create_reservation
      parsed_payload = parse_payload(params)

      guest = Guest.find_or_create_by!(email: guest_params[:email]) do |data|
        data.firstname = guest_params[:firstname]
        data.lastname = guest_params[:lastname]
        data.phone = guest_params[:phone]
      end

      reservation = guest.reservations.find_or_initialize_by(reservation_code: params['reservation_code'])
      reservation.update!(reservation_params.except(:email))

      if reservation
        render json: { message: 'Booking created', data: reservation }, status: :created
      else
        render json: { error: 'Partner not found' }, status: :bad_request
      end
    end

    private

    def parse_payload(params)
      if params.key?('reservation_code') && params['reservation_code'].start_with?('YYY')
        { booking_code: params['reservation_code'], partner: 'Airbnb' }
      elsif params.key?('reservation') && params['reservation']['code'].start_with?('XXX')
        { booking_code: params['reservation']['code'], partner: 'Airbnc' }
      end
    end

    def create_booking(parsed_payload)
      parsed_payload
    end

    def guest_params
      {
        firstname: params['guest']['first_name'],
        lastname: params['guest']['last_name'],
        phone: params['guest']['phone'],
        email: params['guest']['email']
      }
    end

    def reservation_params
      {
        reservation_code: params['reservation_code'],
        start_date: Date.parse(params['start_date']),
        end_date: Date.parse(params['end_date']),
        night_count: params['nights'],
        guest_count: params['guests'],
        children_count: params['children'],
        infant_count: params['infants'],
        adult_count: params['adults'],
        status: params['status'],
        currency: params['currency'],
        payout_price: params['payout_price'],
        security_price: params['security_price'],
        total_price: params['total_price']
      }
    end
  end
end
