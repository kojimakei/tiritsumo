FactoryBot.define do
  factory :room do
    name { Faker::Team.name }
    user_id {2}
    habit {Faker::Team.name}
  end
end
