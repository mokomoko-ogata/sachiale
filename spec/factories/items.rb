FactoryBot.define do
  factory :item do
    item_name { 'ごはん' }
    memo { '美味しい' }
    amount { 100 }
    unit_id { 3 }
    open_date { Faker::Date.backward }
    category_id { 3 }
    bean_id { 3 }
    bread_id { 3 }
    corm_id { 4 }
    egg_id { 3 }
    meat_id { 2 }
    milk_id { 3 }
    mushroom_id { 3 }
    noodle_id { 2 }
    rice_id { 2 }
    seafood_id { 3 }
    seasoning_id { 3 }
    seaweed_id { 3 }
    vegetable_id { 3 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test-image.png'), filename: 'test-image.png')
    end
  end
end
