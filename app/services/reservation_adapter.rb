class ReservationAdapter
  def initialize(payload)
    @payload = payload
  end

  def parse
    raise MethodNotImplemented, 'Each partner must implement its own #parse method'
  end

  def self.for_partner(params)
    if params.key?('reservation_code') && params['reservation_code'].start_with?('YYY')
      AirbnbAdapter.new(params)
    elsif params.key?('reservation') && params['reservation']['code'].start_with?('XXX')
      AirbncAdapter.new(params)
    else
      raise InvalidPayload, 'No partner found for given payload'
    end
  end
end
