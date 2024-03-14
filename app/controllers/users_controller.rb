class UsersController < ApplicationController

	def verify_code
    user = User.find_by_email(params[:email])
    code = params[:code]
    if user.verification_code == code.to_i
      # Clear verification code after successful verification
      user.update(verification_code: nil)
      # sign_in(user) # Assuming you're using Devise for authentication
      render json: { message: "Verification successful", user: user }
    else
      render json: { error: "Invalid verification code" }, status: :unprocessable_entity
    end
  end
end
