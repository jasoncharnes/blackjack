require "rails_helper"

RSpec.describe DealGame, type: :interactor do
  let(:game) { create(:game) }

  before { create_list(:card, 4, game: game) }

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

  describe "card visibility" do
    it "should hide the dealer's second card" do
      subject
      expect(game.dealer_hand.cards.first.visible?).to eq(true)
      expect(game.dealer_hand.cards.second.visible?).to eq(false)
      expect(game.player_hand.cards.first.visible?).to eq(true)
      expect(game.player_hand.cards.second.visible?).to eq(true)
    end
  end
end
