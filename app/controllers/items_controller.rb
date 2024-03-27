class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:item_create, :item_list]

 	def item_create
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
    @item = @restaurant.items.build(item_params)
    if @item.save
      # render json: @item, status: :created
      render json: {
        status: {code: 200, message: 'Item create successfully.'},
        data: ItemSerializer.new(@item).serializable_hash[:data][:attributes]
      }
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def item_update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: {
        status: {code: 200, message: 'Item update successfully.'},
        data: ItemSerializer.new(@item).serializable_hash[:data][:attributes]
      }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def item_list
    @restaurant = current_user.restaurants.find_by(id: params[:restaurant_id])
  
    if @restaurant.nil?
      render json: { message: "Restaurant not found" }, status: :not_found
    else
      @items = @restaurant.items
      render json: @items
    end
  end

  def item_details
    @item = Item.find(params[:id])
    render json: {
        status: {code: 200, message: 'Item Details.'},
        data: ItemSerializer.new(@item).serializable_hash[:data][:attributes]
      }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Item not found' }, status: :not_found
  end

  def search
    query = params[:query]
    if query
      @items = Item.where("name LIKE ?", "%#{query}%")
      if @items.present?
        render json: @items
      else
        render json: {message: "Item not found"}
      end
    else
      render json: { error: 'Query parameter missing' }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image_url, :name, :detail, :price, :size, :ingredients_basic,  :fruits, :category_id, :restaurant_id)
  end
end