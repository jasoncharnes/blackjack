FactoryBot.define do
  factory :game do
    session_id { Faker::Alphanumeric.alphanumeric(number: 20) }

    trait :ended do
      workflow_state { :ended }
    end

    after(:build) do |game|
      game.class.skip_callback(:create, :after, :generate_deck, raise: false)
    end

    trait :with_callbacks do
      after(:build) do |game|
        game.class.set_callback(:create, :after, :generate_deck)
      end
    end
  end
end
