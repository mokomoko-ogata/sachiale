class CreateBuyLists < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_lists do |t|
      t.string :item_name,        null: false
      t.text :buy_memo
      t.integer :amount
      t.references :user,         foreign_key: true
      t.timestamps
    end
  end
end
