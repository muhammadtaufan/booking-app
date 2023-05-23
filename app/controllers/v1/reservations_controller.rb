# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    def create_reservation
      parsed_payload = parse_payload(params)
      response = create_booking(parsed_payload)
      if response
        render json: { message: 'Booking created', data: response }, status: :created
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
      else
        nil
      end
    end

    def create_booking(parsed_payload)
      parsed_payload
    end
  end
end
