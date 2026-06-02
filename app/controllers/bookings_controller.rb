class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show]

  def index
    @bookings = current_user.bookings.includes(:hotel, :room).order(created_at: :desc)
  end

  def show
    @hotel = @booking.hotel
  end

  def create
    @hotel = Hotel.active.find(params[:hotel_id])
    @booking = BookingCreator.new(user: current_user, hotel: @hotel, params: booking_params).call

    if @booking.persisted?
      redirect_to booking_path(@booking), notice: 'Бронирование успешно оформлено!'
    else
      redirect_to hotel_path(
        @hotel,
        checkin: booking_params[:check_in],
        checkout: booking_params[:check_out],
        guests: booking_params[:guests]
      ), alert: @booking.errors.full_messages.join('. ')
    end
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :guests, :room_id)
  end
end
