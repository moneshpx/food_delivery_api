class OrdersController < ApplicationController
  before_action :set_order, only: [:get_orders]
  before_action :authenticate_user!, only: [:create_order, :ongoing_order_items]

  # GET /orders
  def user_orders
    orders = current_user.orders
    render json: orders
  end

  # GET /orders/:id
  def get_orders
    render json: @order
  end

  # POST /orders
  def create_order
    cart = current_user.cart
    if cart.nil? || cart.cart_items.empty?
      render json: { error: 'Your cart is empty' }, status: :unprocessable_entity
      return
    end
    # Calculate total amount based on cart items
    total_amount = calculate_total_amount(cart)
    # Process Payment (Assuming a hypothetical payment_service)
    # if payment_service.process_payment(current_user, total_amount)
      # Build Order
      order = current_user.orders.new(status: :pending)
      cart.cart_items.each do |cart_item|
        order.order_items.build(item: cart_item.item, quantity: cart_item.quantity,status: :ongoing)
      end

      # Save Order
      if order.save!
        # Clear the user's cart after creating the order
        order.update(status: "ongoing")
        cart.cart_items.destroy_all
        render json: order, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    # else
    #   render json: { error: 'Payment failed' }, status: :unprocessable_entity
    # end
  end

  def ongoing_order_items
    # Find ongoing orders for the current user
    ongoing_orders = current_user.orders.where(status: [:ongoing])

    # Retrieve order items associated with ongoing orders
    ongoing_order_items = ongoing_orders.map(&:order_items).flatten

    if ongoing_order_items.present?
      render json: ongoing_order_items.as_json(include: { item: { only: [:id, :name, :price, :image_url] } }), status: :ok
    else
      render json: { message: "Ongoing order items not found" }, status: :not_found
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:item_id, :quantity, :status)
  end

  def calculate_total_amount(cart)
    # Calculate total amount based on cart items
    total_amount = 0
    cart.cart_items.each do |cart_item|
      total_amount += cart_item.item.price * cart_item.quantity
    end
    total_amount
  end

  def payment_service
    # Initialize and return payment service (mocked for demonstration)
    PaymentService.new
  end
end
