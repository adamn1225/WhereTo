class OrdersController < ApplicationController
  before_action :set_poll

  def create
    @order = @poll.orders.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to [@poll, @order], notice: "Your order will be coming soon"
    else
      redirect_to [@poll, @order], notice: "You already ordered"
    end
  end

  def index
    @orders   = @poll.orders.joins(:dish)
    @summary  = @poll.orders
                  .group_by{|o| o.dish}
                  .map{|dish, orders| [dish.name, orders.count]}
                  .to_h
  end

  def show
    @order = @poll.orders.find(params[:id])
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def order_params
    params.require(:order).permit(:dish_id)
  end

end
