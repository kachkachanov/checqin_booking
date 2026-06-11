module HotelsHelper
  def hotel_in_dream_list?(hotel)
    return false unless user_signed_in?

    @dream_hotel_ids ||= current_user.dream_hotels.pluck(:hotel_id)
    @dream_hotel_ids.include?(hotel.id)
  end
end
