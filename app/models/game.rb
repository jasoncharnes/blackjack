class Game < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :hands, dependent: :destroy
  has_one :dealer_hand, -> { dealer }, class_name: "Hand"
  has_one :player_hand, -> { player }, class_name: "Hand"

  after_create :generate_deck
  after_create :generate_hands

  private

  def generate_deck
    cards.import(Card::DECK_GENERATOR.call)
  end

  def generate_hands
    hands.import([{dealer: true}, {dealer: false}])
  end
end
