class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def show
    @favorites = current_user.favorites.includes(:hotel)
  end

  def toggle
    @hotel = Hotel.find(params[:hotel_id])
    favorite = current_user.favorites.find_by(hotel: @hotel)

    if favorite
      favorite.destroy
      flash[:notice] = 'Удалено из избранного'
    else
      current_user.favorites.create(hotel: @hotel)
      flash[:notice] = 'Добавлено в избранное'
    end

    redirect_back(fallback_location: root_path)
  end
end
