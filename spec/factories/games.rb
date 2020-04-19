FactoryBot.define do
  factory :game do
    session_id { Faker::String.random(length: 20) }
  end
end
