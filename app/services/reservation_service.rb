class ReservationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create_new_reservation
    if reservation.new_record?
      execute if valid_params?
    else
      raise ReservationAlreadyExists,
            "Reservation with code #{reservation.reservation_code} already exists"
    end
  end

  private

  def valid_params?
    guest.valid? && reservation.valid?
  end

  def guest
    @guest = Guest.find_or_initialize_by(email: params[:guest_params][:email]) do |data|
      data.assign_attributes(params[:guest_params])
    end
  end

  def reservation
    @reservation ||= Reservation.find_or_initialize_by(reservation_code: params[:reservation_params][:reservation_code]) do |record|
      record.assign_attributes(params[:reservation_params].merge(guest: guest))
    end
  end

  def execute
    ActiveRecord::Base.transaction do
      guest.save!
      reservation.guest = guest
      reservation.save!
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "[ReservationService][create_reservation] Failed to create reservation:#{e.record.errors.full_messages.join(', ')}"
    nil
  end
end
