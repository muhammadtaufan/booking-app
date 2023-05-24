class ReservationService
  def initialize(params)
    @params = params
  end

  def create_reservation
    Rails.logger.info '[ReservationService][create_reservation]Creating reservation started'

    ActiveRecord::Base.transaction do
      guest = create_guest
      reservation = create_reservation_with_guest(guest)

      if reservation
        { success: true, status: :created, message: 'Booking created' }
      else
        Rails.logger.error '[ReservationService][create_reservation] Failed to create reservation'
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::Rollback
    Rails.logger.error '[ReservationService][create_reservation] Rolling back transaction due to error'
    { success: false, status: :unprocessable_entity, message: 'Failed to create reservation' }
  end

  def create_guest
    guest_params = @params[:guest_params]
    Guest.find_or_create_by!(email: guest_params[:email]) do |data|
      data.firstname = guest_params[:firstname]
      data.lastname = guest_params[:lastname]
      data.phone = guest_params[:phone]
    end
  end

  def create_reservation_with_guest(guest)
    reservation_params = @params[:reservation_params]
    reservation = guest.reservations.find_or_initialize_by(reservation_code: reservation_params[:reservation_code])
    reservation.update!(reservation_params)
    reservation
  end
end
