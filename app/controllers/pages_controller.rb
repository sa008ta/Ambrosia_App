class PagesController < ApplicationController
  before_action :require_login, only: [:home, :menu_detail, :order, :information, :settings]

  def landing
  end

  def loading
    @next_path = root_path
  end

  def home
    @user = current_user
    @menu_items = [
      { id: 1, name: "季節のサラダ", description: "新鮮な野菜とドレッシングが合う、さっぱり軽めの一品です。", price: 780 },
      { id: 2, name: "トマトパスタ", description: "トマトの酸味と香りが広がる、定番のごちそうメニューです。", price: 980 },
      { id: 3, name: "コーヒーセット", description: "香り高いコーヒーと一緒に楽しめる、朝にぴったりのセットです。", price: 650 },
      { id: 4, name: "チーズトースト", description: "温かくて香ばしい、満足感のある軽食です。", price: 520 },
      { id: 5, name: "ケーキセット", description: "少し甘めでリラックスできる、デザート感覚の一皿です。", price: 720 },
      { id: 6, name: "ティータイム", description: "ゆったりとしたひと時に合わせたい、上品な飲み物です。", price: 600 }
    ]
  end

  def information
  end

  def settings
  end

  def menu_detail
    @menu_item = find_menu_item(params[:id])
    return if @menu_item

    redirect_to home_path, alert: "指定の商品は見つかりませんでした。"
  end

  def order
    @menu_item = find_menu_item(params[:id])
    if @menu_item.nil?
      redirect_to home_path, alert: "指定の商品は見つかりませんでした。"
      return
    end

    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1

    flash[:notice] = "#{@menu_item[:name]}を#{quantity}個注文しました。"
    redirect_to home_path
  end

  private

  def find_menu_item(id)
    home_menu_items.find { |item| item[:id].to_s == id.to_s }
  end

  def home_menu_items
    [
      { id: 1, name: "季節のサラダ", description: "新鮮な野菜とドレッシングが合う、さっぱり軽めの一品です。", price: 780 },
      { id: 2, name: "トマトパスタ", description: "トマトの酸味と香りが広がる、定番のごちそうメニューです。", price: 980 },
      { id: 3, name: "コーヒーセット", description: "香り高いコーヒーと一緒に楽しめる、朝にぴったりのセットです。", price: 650 },
      { id: 4, name: "チーズトースト", description: "温かくて香ばしい、満足感のある軽食です。", price: 520 },
      { id: 5, name: "ケーキセット", description: "少し甘めでリラックスできる、デザート感覚の一皿です。", price: 720 },
      { id: 6, name: "ティータイム", description: "ゆったりとしたひと時に合わせたい、上品な飲み物です。", price: 600 }
    ]
  end
end
