class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :recipe_name
    validates :explain
    validates :price
    validates :image
  end
end
