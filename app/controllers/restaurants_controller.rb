class RestaurantsController < ApplicationController
	before_action :authenticate_user!

	def create_restaurant
		@restaurant = current_user.restaurants.build(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:name, :image, :address, :working_days, :open_time, :close_time, :documents, :details, :owner_name, :email, :mobile_number, :user_id )
	end

end
