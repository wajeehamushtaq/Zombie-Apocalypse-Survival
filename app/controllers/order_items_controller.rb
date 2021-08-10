class OrderItemsController < ApplicationController
    before_action :authenticate_user!
    def create
        @order = current_order
        @order.update(:user_id => @current_user)
        @order_item = @order.order_items.new(order_params)
        @order.save
        session[:order_id] = @order.id
    end

    def update
        @order = current_order
        @order.update(:user_id => @current_user)
        @order_item = @order.order_items.find(params[:id])
        @order_item.update_attributes(order_params)
        @order_items = current_order.order_items
    end

    def destroy
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @order_item.destroy
        @order_items = current_order.order_items
    end


    private

    def order_params
        params.require(:order_item).permit(:resource_id, :quantity, :user_id)
    end

end
