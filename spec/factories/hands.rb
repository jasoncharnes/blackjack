FactoryBot.define do
  factory :hand do
    game

    trait :dealer do
      dealer { true }
    end

    trait :player do
      dealer { false }
    end
  end
end
