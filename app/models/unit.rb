class Unit < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'グラム' },
    { id: 3, name: '個' },
    { id: 4, name: '枚' },
    { id: 5, name: '本' },
    { id: 6, name: '玉' },
    { id: 7, name: '合' },
    { id: 8, name: '箱' },
    { id: 9, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :items
end