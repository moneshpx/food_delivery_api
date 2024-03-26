class FoodOffersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_offer, only: [:offer_show]

  def all_offers
    @food_offers = current_user.restaurants.flat_map(&:offers)
    render json: @food_offers
  end

  def offer_show
    render json: @offer
  end

  def offer_create
    @offer = Offer.new(offer_params)
    if @offer.save
      render json: @offer, status: :created
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :fixed_discount, :percentage_discount, :code, :valid_from, :valid_until, :restaurant_id, :category_id, :item_id)
  end

end
