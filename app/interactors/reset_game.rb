class ResetGame
  include Interactor

  def call
    context.game.cards.update_all(hand_id: nil, visible: true)
    context.game.hands.update_all(workflow_state: nil)
  end
end
