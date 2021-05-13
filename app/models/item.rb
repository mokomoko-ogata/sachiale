class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :blog_items
  has_many :blogs, through: :blog_items

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :bean
  belongs_to :bread
  belongs_to :corm
  belongs_to :egg
  belongs_to :meat
  belongs_to :milk
  belongs_to :mushroom
  belongs_to :noodle
  belongs_to :rice
  belongs_to :seafood
  belongs_to :seasoning
  belongs_to :seaweed
  belongs_to :vegetable
  belongs_to :unit

  with_options presence: true do
    validates :item_name, length: { maximum: 40 }
    validates :amount, numericality: { with: /\A[0-9]+\z/ }, numericality: { only_integer: true }
    validates :open_date
    validates :image
  end
  validates :memo, length: { maximum: 1_000 }

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :unit_id
  end
end
