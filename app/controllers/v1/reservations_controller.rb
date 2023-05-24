# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    def create_reservation
      adapter = ReservationAdapter.for_partner(params)
      service = ReservationService.new(adapter.parse)
      reservation = service.create_reservation

      if reservation[:success]
        json_success_response(nil, reservation[:status], reservation[:message])
      else
        json_error_response(reservation[:message], reservation[:status])
      end
    end
  end
end
