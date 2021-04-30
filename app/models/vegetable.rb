class Vegetable < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'キャベツ' },
    { id: 3, name: 'レタス類' },
    { id: 4, name: '白菜' },
    { id: 5, name: '玉ねぎ' },
    { id: 6, name: '長ネギ' },
    { id: 7, name: 'もやし' },
    { id: 8, name: 'トマト' },
    { id: 9, name: 'きゅうり' },
    { id: 10, name: 'ナス' },
    { id: 11, name: 'ピーマン類' },
    { id: 12, name: 'かぼちゃ' },
    { id: 13, name: 'ゴーヤ' },
    { id: 14, name: 'とうもろこし' },
    { id: 15, name: 'その他果菜類' },
    { id: 16, name: '大根' },
    { id: 17, name: '生姜' },
    { id: 18, name: '蓮根' },
    { id: 19, name: 'ニンニク' },
    { id: 20, name: 'にんじん' },
    { id: 21, name: 'その他根菜類' },
    { id: 22, name: 'カット野菜' },
    { id: 23, name: 'オレンジ' },
    { id: 24, name: 'りんご' },
    { id: 25, name: 'レモン' },
    { id: 26, name: 'ぶどう' },
    { id: 27, name: '梨' },
    { id: 28, name: 'メロン' },
    { id: 29, name: 'スイカ' },
    { id: 30, name: 'もも' },
    { id: 31, name: 'バナナ' },
    { id: 32, name: 'その他果物類' }
  ]

  include ActiveHash::Associations
  has_many :items
end
