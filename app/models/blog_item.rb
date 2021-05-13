class BlogItem < ApplicationRecord
  belongs_to :blog
  belongs_to :item
end
