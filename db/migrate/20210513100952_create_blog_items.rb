class CreateBlogItems < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_items do |t|
      t.references :blog, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
