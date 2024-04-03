class UsersController < ApplicationController
	def get_locations
		@locations = Geocoder.search(params[:address])
		if @locations.present?
			render json: @locations
		else
			render json: {message: "locations not found"}
		end

	end
end
