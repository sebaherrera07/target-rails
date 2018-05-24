FactoryBot.define do
  factory :target do
    title     { Faker::Simpsons.character }
    topic     { Target::TOPICS.sample[:title] }
    latitude  { Faker::Number.decimal(2, 15) }
    longitude { Faker::Number.decimal(2, 15) }
    size      { Random.rand(100..500) }
    user
  end
end
