class AddressesController < ApplicationController
	before_action :authenticate_user!, only: [:new_address, :my_address, :update_address]

	def new_address
	  @address = current_user.addresses.build(address_params)
    if @address.save
      render json: @address, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
	end

  def my_address
    if current_user.addresses.present?
      @address_list = current_user.addresses
      render json: @address_list
    else
      render json: {message: "Address is not available"}
    end
  end

  def update_address
    @address = current_user.addresses.find(params[:id])
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

	private 
	def address_params
		params.require(:address).permit(:address, :street, :landmark, :label, :postal_code, :latitude, :longitude, :user_id)
	end
end
