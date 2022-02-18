class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, comment:"Producs table" do |t|
      t.string :name, null: false
      t.integer :category, null: false, default: 0
      t.string :barcode, null: false
      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
