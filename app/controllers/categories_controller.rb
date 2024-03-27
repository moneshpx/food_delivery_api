class CategoriesController < ApplicationController
	def all_category
		@categories = Category.all
		render json: @categories
	end

	def search
		query = params[:query].downcase
    @categories = Category.where("LOWER(name) LIKE ?", "%#{query}%")
    if @categories.present?
    	render json: @categories
    else
    	render json: {message: "Categories not found"}
    end
  end
end
