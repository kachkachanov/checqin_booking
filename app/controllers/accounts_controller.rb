class AccountsController < ApplicationController
  before_action :authenticate_user!

  def update_password
    if current_user.update_with_password(password_params)
      bypass_sign_in(current_user)
      redirect_to root_path, notice: 'Пароль успешно изменён.'
    else
      redirect_to root_path, alert: current_user.errors.full_messages.first
    end
  end

  private

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
