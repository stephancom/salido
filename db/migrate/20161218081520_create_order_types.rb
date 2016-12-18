class CreateOrderTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :order_types do |t|
      t.string :name
      t.references :brand, foreign_key: true, null: false

      t.timestamps
    end
  end
end
