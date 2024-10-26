FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 10)   }
  end
end
