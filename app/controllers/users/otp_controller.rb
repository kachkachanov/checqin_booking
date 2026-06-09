class Users::OtpController < ApplicationController
  def show
    
  end

  def verify
    user = User.find_by(id: session[:two_factor_user_id])

    if user.nil?
      redirect_to new_user_session_path, alert: "Сессия истекла, войдите снова"
    elsif user.validate_and_consume_otp!(params[:otp_code])
      session.delete(:two_factor_user_id)
      sign_in(user)
      redirect_to root_path, notice: "Вы успешно вошли!"
    else
      flash[:alert] = "Неверный или устаревший код"
      render :show
    end
  end
end