class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.boolean :damaged, :default => false
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
