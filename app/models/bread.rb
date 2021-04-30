class Bread < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '食パン' },
    { id: 3, name: 'フランスパン' },
    { id: 4, name: 'ナン' },
    { id: 5, name: 'ドーナツ' },
    { id: 6, name: '菓子パン' },
    { id: 7, name: 'その他パン類' }
  ]

  include ActiveHash::Associations
  has_many :items
end
