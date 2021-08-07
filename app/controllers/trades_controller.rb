class TradesController < ApplicationController
  before_action :authenticate_user!
  def index
    @resources = Resource.all
    @order_item = current_order.order_items.new
  end

  def show
    @resource = Resource.find(params[:id])
  end
end
