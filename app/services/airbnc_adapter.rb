class AirbncAdapter < ReservationAdapter
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
      firstname: @payload['reservation']['guest_first_name'],
      lastname: @payload['reservation']['guest_last_name'],
      phone: @payload['reservation']['guest_phone_numbers'][0],
      email: @payload['reservation']['guest_email']
    }
  end

  def reservation_payload
    {
      reservation_code: @payload['reservation']['code'],
      start_date: Date.parse(@payload['reservation']['start_date']),
      end_date: Date.parse(@payload['reservation']['end_date']),
      night_count: @payload['reservation']['nights'],
      guest_count: @payload['reservation']['number_of_guests'],
      children_count: @payload['reservation']['guest_details']['number_of_children'],
      infant_count: @payload['reservation']['guest_details']['number_of_infants'],
      adult_count: @payload['reservation']['guest_details']['number_of_adults'],
      status: @payload['reservation']['status_type'],
      currency: @payload['reservation']['host_currency'],
      payout_price: @payload['reservation']['expected_payout_amount'],
      security_price: @payload['reservation']['listing_security_price_accurate'],
      total_price: @payload['reservation']['total_paid_amount_accurate']
    }
  end
end
