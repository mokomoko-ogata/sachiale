class Rice < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'ご飯' },
    { id: 3, name: '米' },
    { id: 4, name: 'もち米' },
    { id: 5, name: '餅' },
    { id: 6, name: 'その他ごはん類' }
  ]

  include ActiveHash::Associations
  has_many :items
end
