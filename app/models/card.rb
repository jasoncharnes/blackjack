class Card < ApplicationRecord
  DECK_GENERATOR = -> {
    Card::SUITS.map { |suit|
      Card::RANKS.map do |rank|
        {rank: rank, suit: suit}
      end
    }.flatten
  }
  RANKS = 1..13
  SUITS = ["club", "diamond", "heart", "spade"]

  belongs_to :game
  belongs_to :hand, optional: true

  scope :order_by_position, -> { order(position: :asc) }
  scope :played, -> { where.not(hand_id: nil) }
  scope :shuffled, -> { order("RANDOM()") }
  scope :unplayed, -> { where(hand_id: nil) }

  def self.next
    order_by_position.unplayed.first
  end
end
