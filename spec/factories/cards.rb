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
  end
end
