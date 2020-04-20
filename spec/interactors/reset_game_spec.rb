require "rails_helper"

RSpec.describe ResetGame, type: :interactor do
  let(:game) { create(:game) }

  subject { described_class.call(game: game) }

  it "resets all the cards" do
    game.cards.update_all(hand_id: game.hands.first.id)
    expect { subject }.to change { game.cards.played.count }.from(game.cards.count).to(0)
  end

  it "resets all the hand states" do
    game.hands.update(workflow_state: :playing)
    expect { subject }.to change { Hand.with_playing_state.count }.from(game.hands.count).to(0)
  end
end
