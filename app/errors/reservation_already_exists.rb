class ReservationAlreadyExists < StandardError
  def initialize(msg = 'Reservation already exists')
    super
  end
end
