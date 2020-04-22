class Game < ApplicationRecord
  include WorkflowActiverecord

  workflow do
    state :playing do
      event :end, transitions_to: :ended
    end

    state :ended do
      event :play, transitions_to: :playing
    end
  end

  has_many :cards, dependent: :destroy
  has_many :hands, dependent: :destroy
  has_one :dealer_hand, -> { dealer }, class_name: "Hand"
  has_one :player_hand, -> { player }, class_name: "Hand"

  after_create :generate_deck
  after_create :generate_hands

  def result(hand)
    return :blackjack if hand.blackjack? && !dealer_hand.blackjack?
    return :bust if hand.busted?
    return :win if dealer_hand.busted?
    return :win if hand.value > dealer_hand.value
    return :push if hand.value == dealer_hand.value
    :loss
  end

  private

  def generate_deck
    cards.import(Card::DECK_GENERATOR.call)
  end

  def generate_hands
    hands.import([{dealer: true}, {dealer: false}])
  end
end
