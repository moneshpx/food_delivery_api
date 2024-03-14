class ForgotPasswordMailer < ApplicationMailer
  def reset_password_token(user)
		@reset_token = user.verification_code
		mail(to: user.email, subject: 'verification code')
	end
end

