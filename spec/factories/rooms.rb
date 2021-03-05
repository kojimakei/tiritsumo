FactoryBot.define do
  factory :room do
    name { Faker::Team.name }
    user_id {2}
  end
end
