class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :recipe_name, length: { maximum: 40 }
    validates :explain, length: { maximum: 1_000 }
    validates :price, numericality: { only_integer: true }
    validates :image
  end
end
