class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.string :name
      t.integer :price
      t.integer :count
      t.text :description
      t.timestamps
    end
  end
end
