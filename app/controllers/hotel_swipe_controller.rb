class HotelSwipeController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index
  end

  def next_hotel
    excluded_ids = current_user.hotel_likes.pluck(:hotel_id) + current_user.hotel_skips.pluck(:hotel_id)
    @hotel = Hotel.active
                  .where.not(id: excluded_ids)
                  .includes(:vibes)
                  .order('RANDOM()')
                  .first

    if @hotel
      render json: hotel_json(@hotel), status: :ok
    else
      render json: { message: 'No more hotels to swipe' }, status: :ok
    end
  end

  def like
    @hotel = Hotel.find(params[:hotel_id])
    HotelLike.find_or_create_by(user: current_user, hotel: @hotel)
    Favorite.find_or_create_by(user: current_user, hotel: @hotel)

    render json: { message: 'Hotel liked and added to favorites', hotel: hotel_json(@hotel) }, status: :created
  end

  def skip
    @hotel = Hotel.find(params[:hotel_id])
    HotelSkip.find_or_create_by(user: current_user, hotel: @hotel)
    next_hotel
  end

  def liked_hotels
    @hotels = current_user.liked_hotels.includes(:vibes)
    render json: @hotels.map { |hotel| hotel_json(hotel) }, status: :ok
  end

  private

  def hotel_json(hotel)
    {
      id: hotel.id,
      name: hotel.name,
      city: hotel.city,
      hotel_type: hotel.hotel_type,
      base_price_per_night: hotel.display_price,
      rating: hotel.average_rating,
      vibes: hotel.vibes.map { |v| { name: v.name, icon: v.icon } },
      popularity: hotel.popularity_metrics,
      photos: hotel.photos.attached? ? hotel.photos.map { |p| url_for(p) } : []
    }
  end
end
