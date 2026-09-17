# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

products = [
	{ name: "季節のサラダ", description: "新鮮な野菜とドレッシングが合う、さっぱり軽めの一品です。", price: 780, category: "food", image_url: "/dammy.jpg", stock_quantity: 20 },
	{ name: "トマトパスタ", description: "トマトの酸味と香りが広がる、定番のごちそうメニューです。", price: 980, category: "food", image_url: "/dammy.jpg", stock_quantity: 20 },
	{ name: "コーヒーセット", description: "香り高いコーヒーと一緒に楽しめる、朝にぴったりのセットです。", price: 650, category: "drink", image_url: "/dammy.jpg", stock_quantity: 20 },
	{ name: "チーズトースト", description: "温かくて香ばしい、満足感のある軽食です。", price: 520, category: "food", image_url: "/dammy.jpg", stock_quantity: 20 },
	{ name: "ケーキセット", description: "少し甘めでリラックスできる、デザート感覚の一皿です。", price: 720, category: "food", image_url: "/dammy.jpg", stock_quantity: 20 },
	{ name: "ティータイム", description: "ゆったりとしたひと時に合わせたい、上品な飲み物です。", price: 600, category: "drink", image_url: "/dammy.jpg", stock_quantity: 20 }
]

products.each do |attrs|
	product = Product.find_or_initialize_by(name: attrs[:name])
	product.assign_attributes(attrs)
	product.available = true if product.available.nil?
	product.save!

	label = Label.find_or_create_by!(name: attrs[:category]) do |new_label|
		new_label.position = Label.maximum(:position).to_i + 1
	end

	product.labels << label unless product.labels.exists?(label.id)
end
