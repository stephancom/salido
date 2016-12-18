class CreateDayParts < ActiveRecord::Migration[5.0]
  def change
    create_table :day_parts do |t|
      t.string :name
      t.references :location, foreign_key: true, null: false

      t.timestamps
    end
  end
end
