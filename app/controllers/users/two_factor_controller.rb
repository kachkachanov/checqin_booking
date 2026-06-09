class Users::TwoFactorController < ApplicationController
  def show
    # отображает форму ввода кода
  end

  def verify
    user = User.find_by(id: session[:two_factor_user_id])

    if user.nil?
      redirect_to new_user_session_path, alert: "Сессия истекла"
    elsif user.otp_expired?
      redirect_to new_user_session_path, alert: "Код истёк, войдите снова"
    elsif user.otp_valid?(params[:otp_code])
      session.delete(:two_factor_user_id)
      user.update_columns(otp_code: nil, otp_sent_at: nil)
      sign_in(user)
      redirect_to root_path, notice: "Вы успешно вошли!"
    else
      flash[:alert] = "Неверный код"
      render :show
    end
  end
end