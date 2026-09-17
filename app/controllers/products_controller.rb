class ProductsController < ApplicationController
  before_action :require_login
  before_action :require_staff
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.available.includes(:labels).order(created_at: :desc)
    @labels = Label.order(:position, :id)
  end

  def new
    @product = Product.new
    @labels = Label.order(:position, :id)
  end

  def create
    @product = Product.new(base_product_params)
    @labels = Label.order(:position, :id)

    if save_product_with_labels(@product)
      redirect_to products_path, notice: "商品を追加しました。"
    else
      flash.now[:alert] = @product.errors.full_messages.join(" ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @labels = Label.order(:position, :id)
  end

  def update
    @labels = Label.order(:position, :id)

    if update_product_with_labels(@product)
      redirect_to products_path, notice: "商品を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.update(available: false)
    redirect_to products_path, notice: "商品を削除しました。"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def base_product_params
    params.require(:product).permit(:name, :description, :price, :image, :stock_quantity)
  end

  def selected_labels
    selected_label_ids = Array(params.dig(:product, :label_ids)).reject(&:blank?)
    labels = Label.where(id: selected_label_ids).to_a

    new_label_names = params.dig(:product, :new_label_names).to_s.split(/[\n,]/).map(&:strip).reject(&:blank?).uniq

    new_label_names.each do |name|
      label = Label.find_or_initialize_by(name: name)
      if label.new_record?
        label.position = Label.maximum(:position).to_i + 1
        label.save!
      end
      labels << label
    end

    labels.uniq
  end

  def save_product_with_labels(product)
    labels = selected_labels
    if labels.blank?
      product.errors.add(:base, "ラベルを1つ以上選択または入力してください。")
      return false
    end

    Product.transaction do
      product.category = labels.first.name
      product.save!
      product.labels = labels
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def update_product_with_labels(product)
    labels = selected_labels
    if labels.blank?
      product.errors.add(:base, "ラベルを1つ以上選択または入力してください。")
      return false
    end

    Product.transaction do
      product.assign_attributes(base_product_params)
      product.category = labels.first.name
      product.save!
      product.labels = labels
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
