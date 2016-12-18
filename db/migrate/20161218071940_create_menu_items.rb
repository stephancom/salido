class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.references :brand, foreign_key: true, null: false

      t.timestamps
    end
  end
end
