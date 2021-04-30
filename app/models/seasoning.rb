class Seasoning < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'ダシ' },
    { id: 3, name: '塩' },
    { id: 4, name: '醤油' },
    { id: 5, name: 'ごま油' },
    { id: 6, name: '砂糖' },
    { id: 7, name: '酢' },
    { id: 8, name: 'スパイス' },
    { id: 9, name: '料理酒' },
    { id: 10, name: 'みりん' },
    { id: 11, name: 'こしょう' },
    { id: 12, name: 'ワサビ' },
    { id: 13, name: 'オリーブオイル' },
    { id: 14, name: 'ケチャップ' },
    { id: 15, name: 'マヨネーズ' },
    { id: 16, name: 'ソース' },
    { id: 17, name: 'ラー油' },
    { id: 18, name: 'からし' },
    { id: 19, name: 'マーガリン' },
    { id: 20, name: 'ジャム' },
    { id: 21, name: '塩胡椒' },
    { id: 22, name: 'コンソメ' },
    { id: 23, name: '中華スープの素' },
    { id: 24, name: '豆板醤' },
    { id: 25, name: 'ポン酢' },
    { id: 26, name: '白ワイン' },
    { id: 27, name: 'マスタード' },
    { id: 28, name: 'コチュジャン' },
    { id: 29, name: 'その他調味料' }
  ]

  include ActiveHash::Associations
  has_many :items
end
