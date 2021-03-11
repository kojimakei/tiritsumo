FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { '1a1a1a' }
    password_confirmation { password }
    goal                  { 'aaaa' }
    deadline              { Faker::Date.between(from: '2100-01-01 15:00:00', to: '2200-12-31 15:00:00') }
    age_id { 2 }
    category_id { 2 }
    occupation_id { 2 }
  end
end
