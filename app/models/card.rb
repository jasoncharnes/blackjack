class Card < ApplicationRecord
  DECK_GENERATOR = -> {
    Card::SUITS.map { |suit|
      Card::RANKS.map do |rank|
        {rank: rank, suit: suit}
      end
    }.flatten
  }
  FACES = {jack: 11, queen: 12, king: 13}
  RANKS = 1..13
  SUITS = ["club", "diamond", "heart", "spade"]

  belongs_to :game
  belongs_to :hand, optional: true

  scope :for_hand, ->(hand) { where(hand: hand) }
  scope :order_by_position, -> { order(position: :asc) }
  scope :played, -> { where.not(hand_id: nil) }
  scope :shuffled, -> { order("RANDOM()") }
  scope :unplayed, -> { where(hand_id: nil) }
  scope :visible, -> { where(visible: true) }

  def self.next
    order_by_position.unplayed.first
  end

  def ace?
    rank == 1
  end

  def face?
    rank.in?(FACES.values)
  end

  def hide!
    update(visible: false)
  end

  def value
    return 11 if ace?
    return 10 if face?
    rank
  end
end
