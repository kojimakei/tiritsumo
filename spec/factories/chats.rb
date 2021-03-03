FactoryBot.define do
  factory :chat do
    message { Faker::Lorem.sentence }
    association :user
    association :room
  end
end
