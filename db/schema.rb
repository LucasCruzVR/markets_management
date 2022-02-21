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

ActiveRecord::Schema[7.0].define(version: 2022_02_19_132008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "markets", comment: "Markets table", force: :cascade do |t|
    t.string "name", null: false, comment: "Market's name"
    t.string "phone", comment: "Market's phone number"
    t.string "address", comment: "Market's address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_markets_on_name", unique: true
  end

  create_table "markets_products", comment: "Relation between Markets and Products", force: :cascade do |t|
    t.decimal "price", precision: 7, scale: 2, null: false, comment: "Product's price from a specific Market"
    t.integer "market_id", null: false, comment: "Market id"
    t.integer "product_id", null: false, comment: "Product id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", comment: "Products table", force: :cascade do |t|
    t.string "name", null: false, comment: "Product name"
    t.integer "category", default: 0, null: false, comment: "Define which category Product belongs"
    t.string "barcode", null: false, comment: "Barcode number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  add_foreign_key "markets_products", "markets", name: "market_fk"
  add_foreign_key "markets_products", "products", name: "product_fk"
end
