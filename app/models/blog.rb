class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :blog_items
  has_many :items, through: :blog_items

  with_options presence: true do
    validates :recipe_name, length: { maximum: 40 }
    validates :explain, length: { maximum: 2_000 }
    validates :price, numericality: { with: /\A[0-9]+\z/ }, numericality: { only_integer: true }
    validates :image
  end
end
