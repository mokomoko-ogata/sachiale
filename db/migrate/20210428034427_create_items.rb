class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name,        null: false
      t.text   :memo
      t.integer :amount,          null: false
      t.date    :open_date,       null: false
      t.references :user,         foreign_key: true
      t.integer :category_id,     null: false
      t.integer :bean_id
      t.integer :bread_id
      t.integer :corm_id
      t.integer :egg_id
      t.integer :meat_id
      t.integer :milk_id
      t.integer :mushroom_id
      t.integer :noodle_id
      t.integer :rice_id
      t.integer :seafood_id
      t.integer :seasoning_id
      t.integer :seaweed_id
      t.integer :vegetable_id
      t.integer :unit_id,        null: false
      t.timestamps
    end
  end
end
