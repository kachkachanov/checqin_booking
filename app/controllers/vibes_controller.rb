class VibesController < ApplicationController
  def index
    @vibes = Vibe.all
    render json: @vibes, status: :ok
  end

  def hotels
    @vibe = Vibe.find_by(name: params[:vibe_name])
    return render json: { error: 'Vibe not found' }, status: :not_found unless @vibe

    @hotels = Hotel.active.by_vibe(@vibe.name).includes(:vibes, photos_attachments: :blob)

    respond_to do |format|
      format.html { render :hotels }
      format.json { render json: @hotels.map { |hotel| hotel_json(hotel) }, status: :ok }
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
