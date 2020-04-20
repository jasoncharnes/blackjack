class DealGame
  include Interactor

  def call
    2.times.each { hands.each { |hand| hand.draw!(card: next_card) } }
  end

  private

  def hands
    context.game.hands
  end

  def next_card
    context.game.cards.next
  end
end
