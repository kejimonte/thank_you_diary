FactoryBot.define do
  factory :thank do
    content { "ありがとう" }
    association :user
  end
end
