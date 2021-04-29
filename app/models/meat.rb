class Meat < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '牛薄切り肉' },
    { id: 3, name: '牛焼肉用' },
    { id: 4, name: '牛ステーキ用' },
    { id: 5, name: '牛ブロック肉' },
    { id: 6, name: 'その他牛肉' },
    { id: 7, name: '豚薄切り肉' },
    { id: 8, name: '豚生姜焼き用肉' },
    { id: 9, name: '豚ブロック肉' },
    { id: 10, name: '豚焼肉用'},
    { id: 11, name: 'その他豚肉' },
    { id: 12, name: '鳥もも肉' },
    { id: 13, name: '鶏むね肉' },
    { id: 14, name: 'その他鶏肉' },
    { id: 15, name: 'ハム' },
    { id: 16, name: 'ソーセージ' },
    { id: 17, name: 'ベーコン' },
    { id: 18, name: '挽き肉'},
    { id: 19, name: 'その他肉類' }
  ]

  include ActiveHash::Associations
  has_many :items
end