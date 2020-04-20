class StartGame
  include Interactor

  def call
    player_hand.value == 21 ? player_hand.blackjack! : player_hand.play!
    context.game.play! if context.game.can_play?
  end

  private

  def player_hand
    context.game.player_hand
  end
end
