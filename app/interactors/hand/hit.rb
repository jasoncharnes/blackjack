class Hand::Hit
  include Interactor

  def call
    context.hand.draw!(card: context.hand.game.cards.next)
    context.hand.bust! if context.hand.value > 21
  end
end
