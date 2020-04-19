class ResetGame
  include Interactor

  def call
    context.game.cards.update_all(hand_id: nil)
  end
end
