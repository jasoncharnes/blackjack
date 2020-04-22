class StartGame
  include Interactor

  def call
    player_hand.blackjack! if player_hand.value == 21
    dealer_hand.blackjack! if dealer_hand.raw_value == 21

    context.game.play! if context.game.can_play?

    if dealer_hand.blackjack? || player_hand.blackjack?
      context.game.cards.update_all(visible: true)
      context.game.end!
    else
      player_hand.play!
    end
  end

  private

  def dealer_hand
    context.game.dealer_hand
  end

  def player_hand
    context.game.player_hand
  end
end
