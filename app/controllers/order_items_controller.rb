class OrderItemsController < ApplicationController
  before_action :require_login
  before_action :require_staff

  def mark_provided
    order_item = OrderItem.find(params[:id])
    order_item.update!(provided: true)

    redirect_to home_path, notice: "提供済みに更新しました。"
  end
end
