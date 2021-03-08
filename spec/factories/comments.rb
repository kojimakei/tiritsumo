FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence(5) }
    association :user
    association :stack
  end
end
