class Hand::PlayDealer
  include Interactor

  before { context.hand.play! }
  after { context.hand.game.end! }

  def call
    context.hand.cards.update_all(visible: true)

    while context.hand.playing?
      if context.hand.value >= 17
        context.hand.stand!
      else
        Hand::Hit.call(hand: context.hand)
      end
    end
  end
end
