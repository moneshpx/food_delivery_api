class ForgotPasswordsController < ApplicationController
  def forgot_password
 		user = User.find_by_email(params[:email])
	  if user.present?
	    verification_code = generate_otp
	    user.update(verification_code: verification_code, reset_password_sent_at: Time.now)
	    ForgotPasswordMailer.reset_password_token(user).deliver_now

	    render json: { message: 'Verification code sent successfully' }
	  else
	    render json: { error: 'No User found with the provided email' }, status: :not_found
	  end
	end

	def verify_code
    user = User.find_by_email(params[:email])
    code = params[:code]
    if user.verification_code == code.to_i
      render json: { message: "Verification successful", user: user }
    else
      render json: { error: "Invalid verification code" }, status: :unprocessable_entity
    end
  end

	def update
    user = User.find_by(email: params[:email], verification_code: params[:verification_code])
    if user && user.reset_password_sent_at > 2.hours.ago
      user.update(password: params[:password],password_confirmation: params[:password_confirmation], verification_code: nil, reset_password_sent_at: nil)
      render json: { message: "Password reset successful" }, status: :ok
    else
      render json: { error: "Invalid or expired verification code" }, status: :unprocessable_entity
    end
  end

	private

	def generate_otp
	  otp_length = 4
	  verification_code = SecureRandom.random_number(10**otp_length).to_s.rjust(otp_length, '0')
	  return verification_code
	end
end