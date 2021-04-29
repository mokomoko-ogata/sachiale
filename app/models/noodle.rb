class Noodle < ActiveHash::Base
  self.data = [
    { id: 1, name: '--'},
    { id: 2, name: 'うどん'},
    { id: 3, name: 'ぞば'},
    { id: 4, name: 'そうめん'},
    { id: 5, name: '中華麺'},
    { id: 6, name: 'パスタ、スパゲッティ'},
    { id: 7, name: '乾麺'},
    { id: 8, name: 'その他麺類'}
  ]

  include ActiveHash::Associations
  has_many :items
end