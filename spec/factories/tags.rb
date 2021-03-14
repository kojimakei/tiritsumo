FactoryBot.define do
  factory :tag do
    name              { Faker::Lorem.sentence(5) }
  end
end
