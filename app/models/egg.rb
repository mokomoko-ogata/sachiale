class egg < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '鶏卵' },
    { id: 3, name: 'うずらの卵' },
    { id: 4, name: 'うこっけいの卵' },
    { id: 5, name: 'その他卵類' }
  ]
end