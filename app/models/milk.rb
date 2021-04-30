class Milk < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '牛乳' },
    { id: 3, name: 'チーズ' },
    { id: 4, name: 'ヨーグルト' },
    { id: 5, name: '生クリーム' },
    { id: 6, name: 'バター' },
    { id: 7, name: '練乳' },
    { id: 8, name: 'その他乳製品' }
  ]

  include ActiveHash::Associations
  has_many :items
end
