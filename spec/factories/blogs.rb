FactoryBot.define do
  factory :blog do
    recipe_name {'すき焼き定食'}
    explain {'とても美味しいです'}
    price {298}
    association :user
    after(:build) do |blog|
      blog.image.attach(io: File.open('public/images/test-image.png'), filename: 'test-image.png')
    end
  end
end
