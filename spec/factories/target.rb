FactoryBot.define do
  factory :target do
    title     { Faker::Simpsons.character }
    topic     { Target::TOPICS.sample }
    latitude  { Faker::Number.decimal(2, 15) }
    longitude { Faker::Number.decimal(2, 15) }
    size      { Random.rand(100..1000) }
  end
end
