# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    def create_reservation
      adapter = ReservationAdapter.for_partner(params)
      booking_params = adapter.parse
      service = ReservationService.new(booking_params)

      if service.create_new_reservation
        json_success_response(nil, :created, 'Booking Created')
      else
        json_error_response('Unable to process the booking', :unprocessable_entity)
      end
    end
  end
end
