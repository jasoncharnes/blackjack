class DealGame
  include Interactor

  def call
    2.times.each { hands.each { |hand| draw_card(hand) } }
  end

  private

  def draw_card(hand)
    next_card.hide! if hand.dealer? && Card.for_hand(hand).any?

    hand.draw!(card: next_card)
  end

  def hands
    context.game.hands
  end

  def next_card
    context.game.cards.next
  end
end
