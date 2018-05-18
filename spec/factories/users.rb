FactoryBot.define do
  factory :user do
    email                   { Faker::Internet.unique.email }
    name                    { Faker::Name.name }
    password                '123456'
    password_confirmation   '123456'
    confirmed_at            Date.today
  end
end
