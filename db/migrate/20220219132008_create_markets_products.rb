class CreateMarketsProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :markets_products, comment: "Relation between Markets and Products" do |t|
      t.decimal :price, precision: 7, scale: 2, null: false, comment: "Product's price from a specific Market"
      t.integer :market_id, null: false, comment: "Market id"
      t.integer :product_id, null: false, comment: "Product id"
      t.timestamps
    end

    add_foreign_key :markets_products, :markets, column: :market_id, name: "market_fk"
    add_foreign_key :markets_products, :products, column: :product_id, name: "product_fk"
  end
end
