class Supervisor::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_supervisor!

  layout 'supervisor'

  def index
    hotel_ids = current_user.hotels.select(:id)

    @bookings = Booking.confirmed
                        .where(hotel_id: hotel_ids)
                        .includes(:hotel, :room)
                        .order(created_at: :desc)
                        .limit(100)
  end

  private

  def require_supervisor!
    unless current_user.supervisor?
      redirect_to root_path, alert: 'Доступ запрещён. Только для супервайзоров.'
    end
  end
end
