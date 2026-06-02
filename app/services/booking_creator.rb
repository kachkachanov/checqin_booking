class BookingCreator
  def initialize(user:, hotel:, params:)
    @user = user
    @hotel = hotel
    @params = params
  end

  def call
    booking = @user.bookings.build(booking_attributes)
    booking.hotel = @hotel
    booking.status = 'confirmed'

    if booking.room_id.blank? && @hotel.rooms.available.any?
      booking.room = pick_room(booking)
    end

    booking.save
    booking
  end

  private

  def booking_attributes
    @params.permit(:check_in, :check_out, :guests, :room_id)
  end

  def pick_room(booking)
    @hotel.rooms.available
          .where('capacity >= ?', booking.guests)
          .order(:price_per_night)
          .find { |room| room.bookable_between?(booking.check_in, booking.check_out) }
  end
end
