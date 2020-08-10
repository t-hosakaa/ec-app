class AddColumnToGoods < ActiveRecord::Migration[6.0]
  def change
    add_column :goods, :image, :text
  end
end
