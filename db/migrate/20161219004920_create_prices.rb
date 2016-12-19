class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.decimal :amount, precision: 5, scale: 2, null: false, default: 0
      t.references :menu_item, foreign_key: true, null: false
      t.references :price_level, foreign_key: true, null: false
      t.index [:menu_item_id, :price_level_id], unique: true
      t.index [:price_level_id, :menu_item_id], unique: true # not sure, do I need both?

      t.timestamps
    end
  end
end
