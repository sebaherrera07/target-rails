FactoryBot.define do
  factory :target do
    title                   { Faker::Simpsons.character }
    topic                   { 'Series' }
    latitude                { Faker::Number.decimal(2, 15) }
    longitude               { Faker::Number.decimal(2, 15) }
    size                    { Random.rand(100..1000) }
  end
end
