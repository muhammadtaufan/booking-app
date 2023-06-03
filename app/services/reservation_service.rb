class ReservationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create_new_reservation
    Rails.logger.info '[ReservationService][create_reservation]Creating reservation started'
    execute if valid_params?
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
      if reservation.save && guest.save
        Rails.logger.info '[ReservationService][create_reservation] Reservation created successfully'
      else
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::Rollback
    Rails.logger.error '[ReservationService][create_reservation] Failed to create reservation'
    nil
  end
end
