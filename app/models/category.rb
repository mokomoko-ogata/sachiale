class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'お肉類' },
    { id: 3, name: '野菜・果物類' },
    { id: 4, name: '魚介類' },
    { id: 5, name: '乾物・海藻類' },
    { id: 6, name: 'きのこ・山菜類' },
    { id: 7, name: '卵類' },
    { id: 8, name: 'イモ類' },
    { id: 9, name: 'パン類' },
    { id: 10, name: 'ごはん類' },
    { id: 11, name: '乳製品類' },
    { id: 12, name: '豆・豆腐・豆腐加工品類' },
    { id: 13, name: '麺類' },
    { id: 14, name: '調味料' },
    { id: 15, name: '飲み物' }
  ]

  include ActiveHash::Associations
  has_many :items
end
