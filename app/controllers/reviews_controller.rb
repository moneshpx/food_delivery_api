class ReviewsController < ApplicationController
	before_action :authenticate_user!,only: [:create_review, :update_review]
	before_action :set_reviewable, only: [:create_review]

  def create_review
    @review = @reviewable.reviews.new(review_params)
    @review.user_id = current_user.id 
    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update_review  
	  @review = Review.find_by(id: params[:id])	  
	  if @review.nil?
	    render json: { message: "Review not found" }, status: :not_found
	  else
	    if @review.update(review_params)
	      render json: { success: true, message: 'Review updated successfully' }
	    else
	      render json: { success: false, errors: @review.errors.full_messages }, status: :unprocessable_entity
	    end
	  end
  end

  def restaurant_reviews
  	restaurant = Restaurant.find(params[:restaurant_id])
		average_rating = restaurant.average_rating
		render json: average_rating
  end

  def item_reviews
  	item = Item.find(params[:item_id])
		average_rating = item.average_rating
		render json: average_rating
  end

  def top_rated_restaurant
  	@top_rated_restaurants = Restaurant.joins(:reviews)
     .select('restaurants.*, AVG(reviews.rating) AS avg_rating')
     .group('restaurants.id')
     .order('avg_rating DESC')
     .limit(5)

    render json: @top_rated_restaurants, status: :ok
  end

  private

  def set_reviewable
    if params[:restaurant_id]
      @reviewable = Restaurant.find(params[:restaurant_id])
    elsif params[:item_id]
      @reviewable = Item.find(params[:item_id])
    else
     	render json: {message:"Invalid params provided"}
    end
  end

  def review_params
    params.require(:review).permit(:id, :rating, :comment, :restaurant_id, :item_id)
  end
end
