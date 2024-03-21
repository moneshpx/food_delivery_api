class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def food_list
    if current_user.present? && current_user.role == "seller"
      @food_lists = current_user.foods
      render json: @food_lists
    else
      @food_lists = Food.all
      render json: @food_lists
    end
  end

  def create
  	if current_user.role == "seller"
	    @food = current_user.foods.build(food_params)
	    if @food.save
	      render json: @food, status: :created
	    else
	      render json: @food.errors, status: :unprocessable_entity
	    end
	  else
	  	 render json:{message: "Food only create by seller"}
	  end
  end

  def food_details
    @food = Food.find(params[:id])
    render json: @food
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Food not found' }, status: :not_found
  end

  private
  def food_params
    params.require(:food).permit(:name, :detail, :price, :image_url, :ingredints_basic, :fruits, :user_id)
  end
end


User<=Resturent=>item_create

User<resturent
User<Item

Item assigne resturent 
