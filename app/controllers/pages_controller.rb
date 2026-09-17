class PagesController < ApplicationController
  before_action :require_login, only: [:home, :account_top, :history, :language_settings, :menu_detail, :order, :information, :settings]
  before_action :require_customer, only: [:menu_detail, :order]
  before_action :redirect_logged_in_user_from_landing, only: [:landing]
  before_action :redirect_to_language_setup, only: [:landing]
  skip_before_action :redirect_to_language_setup, if: proc { current_user&.language.present? }

  def landing
  end

  def loading
    @next_path = root_path
  end

  def home
    @user = current_user

    if @user.staff?
      @ordered_items = OrderItem.includes(order: :user).order(created_at: :desc).limit(100)
      render :staff_home and return
    end

    @menu_items = Product.available.order(created_at: :desc)
  end

  def account_top
    @user = current_user
  end

  def history
    @orders = current_user.orders.includes(:order_items).order(created_at: :desc)
  end

  def language_settings
    @user = current_user
  end

  def information
  end

  def settings
  end

  def menu_detail
    @menu_item = Product.available.find_by(id: params[:id])
    return if @menu_item

    redirect_to home_path, alert: "指定の商品は見つかりませんでした。"
  end

  def order
    @menu_item = Product.available.find_by(id: params[:id])
    if @menu_item.nil?
      redirect_to home_path, alert: "指定の商品は見つかりませんでした。"
      return
    end

    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1

    ActiveRecord::Base.transaction do
      order = current_user.orders.create!(total_amount: @menu_item.price * quantity)
      order.order_items.create!(
        product: @menu_item,
        quantity: quantity,
        unit_price: @menu_item.price,
        product_name: @menu_item.name,
        product_category: @menu_item.category
      )
    end

    flash[:notice] = "#{@menu_item.name}を#{quantity}個注文しました。"
    redirect_to home_path
  end

  private

  def redirect_to_language_setup
    return if current_user.nil?
    return if current_user.language.present?

    redirect_to language_settings_path, notice: "言語設定をしてください。"
  end

  def redirect_logged_in_user_from_landing
    return unless logged_in?

    redirect_to home_path, notice: "ログイン済みのためホームへ移動しました。"
  end
end
