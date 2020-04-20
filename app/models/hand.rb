class Hand < ApplicationRecord
  belongs_to :game
  has_many :cards

  scope :dealer, -> { where(dealer: true) }
  scope :player, -> { where(dealer: false) }

  def draw!(card:)
    cards << card
  end

  def value
    hand_value = cards.sum(&:value)

    if cards.any?(&:ace?)
      hand_value -= 10 while hand_value > 21
    end

    hand_value
  end
end
