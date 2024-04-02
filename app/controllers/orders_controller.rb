class OrdersController < ApplicationController
  before_action :set_order, only: [:get_orders]
  before_action :authenticate_user!, only: [:create_order]

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
      order = current_user.orders.build(status: :pending)

      cart.cart_items.each do |cart_item|
        order.order_items.build(item: cart_item.item, quantity: cart_item.quantity)
      end

      # Save Order
      if order.save
        # Clear the user's cart after creating the order
        cart.cart_items.destroy_all
        render json: order, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    # else
    #   render json: { error: 'Payment failed' }, status: :unprocessable_entity
    # end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :quantity, :status)
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
