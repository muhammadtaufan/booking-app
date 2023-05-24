# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    def create_reservation
      adapter = ReservationAdapter.for_partner(params)
      booking_params = adapter.parse

      guest_params = booking_params[:guest_params]
      guest = create_guest(guest_params)

      reservation_params = booking_params[:reservation_params]
      reservation = create_reservation_with_guest(guest, reservation_params)

      if reservation
        json_success_response(nil, :created, 'Booking created')
      else
        json_error_response(reservation.errors, :unprocessable_entity)
      end
    end

    private

    def create_guest(guest_params)
      Guest.find_or_create_by!(email: guest_params[:email]) do |data|
        data.firstname = guest_params[:firstname]
        data.lastname = guest_params[:lastname]
        data.phone = guest_params[:phone]
      end
    end

    def create_reservation_with_guest(guest, reservation_params)
      reservation = guest.reservations.find_or_initialize_by(reservation_code: reservation_params[:reservation_code])
      reservation.update!(reservation_params)
      reservation
    end
  end
end
