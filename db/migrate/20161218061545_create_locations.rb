class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.references :brand, foreign_key: true, null: false

      t.timestamps
    end
  end
end
