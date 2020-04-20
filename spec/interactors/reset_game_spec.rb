require "rails_helper"

RSpec.describe ResetGame, type: :interactor do
  let(:game) { create(:game) }

  subject { described_class.call(game: game) }

  before do
    game.cards.first.update(hand: game.hands.first)
    game.cards.second.update(hand: game.hands.first)
  end

  it "reset all the cards" do
    expect { subject }.to change { game.cards.played.count }.from(2).to(0)
  end
end
