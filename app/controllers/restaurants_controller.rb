class RestaurantsController < ApplicationController
	before_action :authenticate_user!, only: [:create_restaurant]

	def create_restaurant
		@restaurant = current_user.restaurants.build(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
	end

	def restaurant_details
		@restaurant = Restaurant.find(params[:id])
		render json: @restaurant, status: :ok
		rescue ActiveRecord::RecordNotFound
      render json: { error: 'Restaurant not found' }, status: :not_found
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:name, :image, :address, :open_time, :close_time, :documents, :details, :owner_name, :email, :mobile_number, :user_id, working_days: [])
	end

end
