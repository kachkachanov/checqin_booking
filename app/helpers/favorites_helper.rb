module FavoritesHelper
  def hotel_favorited?(hotel)
    favorite_hotel_ids.include?(hotel.id)
  end

  def favorite_hotel_ids
    @favorite_hotel_ids ||= user_signed_in? ? current_user.favorites.pluck(:hotel_id) : []
  end
end
