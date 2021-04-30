class BuyList < ApplicationRecord
  belongs_to :user

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :buy_memo, length: { maximum: 1_000 }
  validates :amount, numericality: { with: /\A[0-9]+\z/ }, numericality: { only_integer: true }
end
