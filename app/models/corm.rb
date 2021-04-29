class Corm < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'ジャガイモ' },
    { id: 3, name: 'さつまいも' },
    { id: 4, name: '里芋' },
    { id: 5, name: '長芋、山芋' },
    { id: 6, name: 'こんにゃく類' },
    { id: 95, name: '自然薯' },
    { id: 96, name: 'その他芋類' }
  ]

  include ActiveHash::Associations
  has_many :items
end