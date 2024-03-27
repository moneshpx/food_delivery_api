class CartsController < ApplicationController
	before_action :authenticate_user!

  def add_to_cart
  	@item = Item.find(params[:item_id])
    quantity = params["cartitem"]["quantity"].to_i # Convert quantity to integer
    unit_price = @item.price
  	@cart_item = current_user.cart.cart_items.build(item: @item, quantity: quantity, unit_price: unit_price)
    if @cart_item.save
      render json: {
      cart_item: @cart_item,
      item: @item.as_json(only: [:id, :name, :price, :image_url]) # Include only desired attributes of the item
    }, status: :created
    else
      render json: { error: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

	def delete_to_cart
	  @cart_item = current_user.cart_items.find_by(id: params[:id])
	  if @cart_item
	    @cart_item.destroy
	    render json: { message: "Cart item destroyed", item: @cart_item }, status: :ok
	  else
	    render json: { message: "Cart item not found" }, status: :not_found
	  end
	end

  def all_carts
  	@cart_items = current_user.cart.cart_items.includes(:item)
  
	  if @cart_items.present?
	    render json: @cart_items.as_json(include: { item: { only: [:id, :name, :price, :image_url] } }), status: :ok
	  else
	    render json: { message: "Cart items not found" }, status: :not_found
	  end
  end

  # GET /cart_total_price
  def cart_total_price
    total_price = current_user.cart.calculate_total_price
    render json: { total_price: total_price }
  end
end
