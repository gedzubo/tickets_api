FactoryBot.define do
  factory :ticket_option do
    name { Faker::Lorem.sentence(word_count: 3) }
    desc { Faker::Lorem.paragraph(sentence_count: 2) }
    allocation { 10 }
  end
end
