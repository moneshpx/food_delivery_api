class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_food, only: [:show, :update, :destroy]

  def food_list
    if current_user.present? && current_user.role == "seller"
      @food_lists = current_user.foods
      render json: @food_lists
    else
      @food_lists = Food.all
      render json: @food_lists
    end
  end

  def show
    render json: @food
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

  # Update and Destroy actions remain the same
  def update
  end

  def destroy
  end


  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :detail, :price, :image_url, :ingredints_basic, :fruits, :user_id)
  end
end
