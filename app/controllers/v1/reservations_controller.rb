# frozen_string_literal: true

module V1
  class ReservationsController < ApplicationController
    def create_reservation
      p 'reservation api called'
      parsed_payload = parse_payload(params)
    end

    private

    def parse_payload(params)
      if params.key?('reservation_code') && params['reservation_code'].start_with?('YYY')
        p 'payload 1'
        p params
      elsif params.key?('reservation') && params['reservation']['code'].start_with?('XXX')
        p 'payload 2'
        p params
      else
        p 'no client found'
      end
    end
  end
end
