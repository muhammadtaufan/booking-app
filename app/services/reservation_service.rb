class ReservationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create_new_reservation
    reservation.new_record? ? create_reservation : update_reservation
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "[ReservationService][create_reservation] Failed to create reservation: #{e.record.errors.full_messages.join(', ')}"
    nil
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

  def create_reservation
    return unless valid_params?

    ActiveRecord::Base.transaction do
      guest.save!
      reservation.guest = guest
      reservation.save!
    end
  end

  def update_reservation
    updated_params = params[:reservation_params].reject do |k, v|
      reservation_attribute = reservation.send(k)

      if reservation_attribute.is_a? BigDecimal
        reservation_attribute.to_f == v.to_f
      else
        reservation_attribute == v
      end
    end

    unless updated_params.any?
      Rails.logger.info "[ReservationService][update_reservation] Reservation with code #{reservation.reservation_code} already exists without any changes"
      raise ReservationAlreadyExists,
            "Reservation with code #{reservation.reservation_code} already exists without any changes"
    end
    reservation.update!(updated_params)
  end
end
