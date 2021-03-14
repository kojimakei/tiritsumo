FactoryBot.define do
  factory :stack_tag do
    association :stack
    association :tag
  end
end
