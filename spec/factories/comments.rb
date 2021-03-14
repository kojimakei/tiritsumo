FactoryBot.define do
  factory :comment do
    text { Faker::Internet.password(min_length: 6) }
    association :user
    association :stack
  end
end
