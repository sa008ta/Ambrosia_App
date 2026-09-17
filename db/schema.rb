# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 202609170006) do
  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "order_id", null: false
    t.string "product_category", null: false
    t.integer "product_id"
    t.string "product_name", null: false
    t.integer "quantity", default: 1, null: false
    t.integer "unit_price", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "total_amount", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.boolean "available", default: true, null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "image_url"
    t.string "name", null: false
    t.integer "price", default: 0, null: false
    t.integer "stock_quantity", default: 0, null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "language", default: "ja", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "role", default: "customer", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products", on_delete: :nullify
  add_foreign_key "orders", "users"
end
