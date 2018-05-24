FactoryBot.define do
  factory :user do
    email                   { Faker::Internet.unique.email }
    name                    { Faker::Name.name }
    password                'password'
    password_confirmation   'password'
    confirmed_at            Date.today

    # user_with_targets will create target data after the user has been created
    factory :user_with_targets do
      transient do
        targets_count 4
      end
      after(:create) do |user, evaluator|
        create_list(:target, evaluator.targets_count, user: user)
      end
    end
  end
end
