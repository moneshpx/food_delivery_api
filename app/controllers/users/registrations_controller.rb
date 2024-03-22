# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private
  def respond_with(current_user, _opts = {})
    if resource.persisted?
      if resource.restaurant_name.present? # Check if the signed-up user is a seller
        render json: {
          status: { code: 200, message: 'Seller signed up successfully.' },
          data: {
            id: current_user.id,
            restaurant_name: current_user.restaurant_name,
            owner_name: current_user.owner_name,
            email: current_user.email
          }
        }
      else
        render json: {
          status: { code: 200, message: 'User signed up successfully.' },
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      end
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
