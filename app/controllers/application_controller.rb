class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_favorite_hotel_ids

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def require_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: 'Доступ разрешён только администратору.'
  end

  def load_favorite_hotel_ids
    @favorite_hotel_ids = user_signed_in? ? current_user.favorites.pluck(:hotel_id) : []
  end
end
