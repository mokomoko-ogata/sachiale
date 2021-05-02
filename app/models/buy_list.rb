class BuyList < ApplicationRecord
  belongs_to :user

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :buy_memo, length: { maximum: 1_000 }
  validates :amount, numericality: { only_integer: true }, numericality: { with: /\s |\A[0-9]+\z/ }, allow_nil: true
end
