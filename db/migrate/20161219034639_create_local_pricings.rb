class CreateLocalPricings < ActiveRecord::Migration[5.0]
  def change
    create_table :local_pricings do |t|
    	t.references :location, foreign_key: true, null: false
      t.references :price_level, foreign_key: true, null: false
      t.references :order_type, foreign_key: true, null: false
      t.references :day_part, foreign_key: true

      t.index [:price_level_id, :order_type_id, :day_part_id], unique: true, name: :local_pricing_index # do I need to do permutations of this? seems wrong.

      t.timestamps
    end
  end
end
