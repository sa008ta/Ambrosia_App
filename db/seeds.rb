# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


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
