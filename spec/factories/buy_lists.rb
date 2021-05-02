FactoryBot.define do
  factory :buy_list do
    item_name { 'キャベツ' }
    buy_memo { '美味しいキャベツ' }
    amount { 200 }
    unit_id { 2 }
    association :user
  end
end
