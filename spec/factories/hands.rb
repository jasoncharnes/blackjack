FactoryBot.define do
  factory :hand do
    game

    trait :dealer do
      dealer { true }
    end

    trait :player do
      dealer { false }
    end

    trait :playing do
      workflow_state { :playing }
    end
  end
end
