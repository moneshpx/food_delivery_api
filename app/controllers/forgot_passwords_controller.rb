class ForgotPasswordsController < ApplicationController
  def forgot_password
 		user = User.find_by_email(params[:email])
	  if user.present?
	    verification_code = generate_otp
	    user.update(verification_code: verification_code)
	    ForgotPasswordMailer.reset_password_token(user).deliver_now

	    render json: { message: 'Verification code sent successfully' }
	  else
	    render json: { error: 'No User found with the provided email' }, status: :not_found
	  end
	end

	private
	def generate_otp
	  otp_length = 4
	  verification_code = SecureRandom.random_number(10**otp_length).to_s.rjust(otp_length, '0')

	  return verification_code
	end
end