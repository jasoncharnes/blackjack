FactoryBot.define do
  factory :game do
    session_id { Faker::String.random(length: 20) }

    trait :ended do
      workflow_state { :ended }
    end
  end
end
