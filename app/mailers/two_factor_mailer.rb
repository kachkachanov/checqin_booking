class TwoFactorMailer < ApplicationMailer
  def otp_email(user, otp)
    @user = user
    @otp = otp
    mail(to: @user.email, subject: "Код подтверждения входа")
  end
end