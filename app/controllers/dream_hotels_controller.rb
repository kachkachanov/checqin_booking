class DreamHotelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @dream_hotels = current_user.dream_hotel_list.includes(:vibes)
    
    respond_to do |format|
      format.html
      format.json { render json: @dream_hotels.map { |hotel| hotel_json(hotel) }, status: :ok }
    end
  end

  def create
    hotel_id = params[:hotel_id] || params.dig(:dream_hotel, :hotel_id)
    @hotel = Hotel.find(hotel_id)
    @dream_hotel = DreamHotel.find_or_create_by(user: current_user, hotel: @hotel)
    
    respond_to do |format|
      format.html { redirect_back fallback_location: dream_hotels_path, notice: 'Отель добавлен в места мечты' }
      format.json { render json: { message: 'Hotel added to dream list', dream_hotel_id: @dream_hotel.id, hotel: hotel_json(@hotel) }, status: :created }
    end
  end

  def destroy
    @dream_hotel = current_user.dream_hotels.find_by(hotel_id: params[:id])
    return render json: { error: 'Dream hotel not found' }, status: :not_found unless @dream_hotel

    @dream_hotel.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: dream_hotels_path, notice: 'Отель удалён из мест мечты' }
      format.json { render json: { message: 'Hotel removed from dream list' }, status: :ok }
    end
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
