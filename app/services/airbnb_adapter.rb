class AirbnbAdapter < ReservationAdapter
  def initialize(payload)
    super(payload)
  end

  def parse
    {
      guest_params: guest_payload,
      reservation_params: reservation_payload
    }
  end

  private

  def guest_payload
    {
      firstname: @payload['guest']['first_name'],
      lastname: @payload['guest']['last_name'],
      phone: @payload['guest']['phone'],
      email: @payload['guest']['email']
    }
  end

  def reservation_payload
    {
      reservation_code: @payload['reservation_code'],
      start_date: Date.parse(@payload['start_date']),
      end_date: Date.parse(@payload['end_date']),
      night_count: @payload['nights'],
      guest_count: @payload['guests'],
      children_count: @payload['children'],
      infant_count: @payload['infants'],
      adult_count: @payload['adults'],
      status: @payload['status'],
      currency: @payload['currency'],
      payout_price: @payload['payout_price'],
      security_price: @payload['security_price'],
      total_price: @payload['total_price']
    }
  end
end
