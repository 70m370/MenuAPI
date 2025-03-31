class AddPriceToMenuItem < ActiveRecord::Migration[8.0]
  def change
    add_column :menu_items, :price, :decimal
    add_reference :menu_items, :item, null: false, foreign_key: true
  end
end
