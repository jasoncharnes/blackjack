require "rails_helper"

RSpec.describe DealGame, type: :interactor do
  let(:game) { create(:game) }

  subject { described_class.call(game: game) }

  it "should assign four cards" do
    expect { subject }.to change { game.cards.played.count }.from(0).to(4)
  end

  it "should assign two of the cards to the dealer" do
    expect { subject }.to change { game.dealer_hand.cards.count }.from(0).to(2)
  end

  it "should assign two of the cards to the player" do
    expect { subject }.to change { game.player_hand.cards.count }.from(0).to(2)
  end

  it "should set the game to active" do
    expect { subject }.to change { game.active }.from(false).to(true)
  end
end
