class CreateMarkets < ActiveRecord::Migration[7.0]
  def change
    create_table :markets, comment: "Markets table" do |t|
      t.string :name, null: false, comment: "Market's name"
      t.string :phone, comment: "Market's phone number"
      t.string :address, comment: "Market's address"
      t.timestamps
    end

    add_index :markets, :name, unique: true
  end
end
