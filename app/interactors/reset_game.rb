class ResetGame
  include Interactor

  def call
    context.game.cards.update_all(hand_id: nil)
    context.game.hands.update_all(workflow_state: nil)
  end
end
