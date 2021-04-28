class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name,        null: false
      t.text   :memo,             null: false
      t.integer :category_id,     null: false
      t.integer :amount,          null: false
      t.date    :open_date,       null: false
      t.references :user,         foreign_key: true
      t.timestamps
    end
  end
end
