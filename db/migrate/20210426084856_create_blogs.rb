class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :recipe_name,     null: false
      t.text :explain,           null: false
      t.integer :price,          null: false
      t.references :user,        foreign_key: true
      t.timestamps
    end
  end
end
