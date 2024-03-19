class ProfilesController < ApplicationController
	before_action :authenticate_user!
  
  # GET /profile_info
  def profile_info
    user = current_user
    render json: user, only: [:id, :name, :phone_number, :email, :bio, :profile_image]
  end

  # PATCH /profile_update
  def update_profile
    user = current_user
    if user.update(profile_params)
      render json: user, only: [:id, :name, :phone_number, :email, :bio, :profile_image], status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :phone_number, :email, :bio, :profile_image)
  end
end
