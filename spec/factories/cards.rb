FactoryBot.define do
  factory :card do
    game
    rank { Card::RANKS.to_a.sample }
    suit { Card::SUITS.sample }

    trait :with_hand do
      hand
    end

    trait :ace do
      rank { 1 }
    end

    trait :hidden do
      visible { false }
    end

    trait :face do
      rank { Card::FACES.values.first }
    end

    trait :rank do
      rank { Faker::Number.within(range: 2..10) }
    end
  end
end
