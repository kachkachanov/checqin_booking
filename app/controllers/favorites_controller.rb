class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authenticate_user_for_toggle!, only: [:toggle]

  def show
    @favorites = current_user.favorites.includes(:hotel).joins(:hotel).merge(Hotel.active)
  end

  def toggle
    @hotel = Hotel.active.find(params[:hotel_id])
    favorite = current_user.favorites.find_by(hotel: @hotel)

    if favorite
      favorite.destroy
      favorited = false
      message = 'Удалено из избранного'
    else
      current_user.favorites.create!(hotel: @hotel)
      favorited = true
      message = 'Добавлено в избранное'
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: message }
      format.json { render json: { favorited: favorited, message: message, hotel_id: @hotel.id } }
    end
  end

  private

  def authenticate_user_for_toggle!
    return if user_signed_in?

    respond_to do |format|
      format.html do
        redirect_to new_user_session_path, alert: 'Войдите, чтобы сохранять отели в избранное'
      end
      format.json do
        render json: {
          error: 'auth_required',
          message: 'Войдите, чтобы сохранять отели в избранное',
          login_url: new_user_session_path
        }, status: :unauthorized
      end
    end
  end
end
