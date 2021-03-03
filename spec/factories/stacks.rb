FactoryBot.define do
  factory :stack do
    text              { 'test' }
    date              { '2000-01-01 15:00:00' }
    work_time_id      { 2 }
    achieved          { 1 }
    association :user
  end
end
