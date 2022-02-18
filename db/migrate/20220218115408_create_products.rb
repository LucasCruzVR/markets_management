class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, comment:"Products table" do |t|
      t.string :name, null: false, comment: "Product name"
      t.integer :category, null: false, default: 0, comment: "Define which category Product belongs"
      t.string :barcode, null: false, comment: "Barcode number"
      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
