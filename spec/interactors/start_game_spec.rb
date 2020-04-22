require "rails_helper"

RSpec.describe StartGame, type: :interactor do
  let(:game) { create(:game) }

  subject { described_class.call(game: game) }

  context "when the player has blackjack" do
    before { allow(game.player_hand).to receive(:value).and_return(21) }

    it "sets the player hand state to blackjack" do
      expect { subject }.to change { game.player_hand.blackjack? }.from(false).to(true)
    end

    it "should end the game" do
      expect { subject }.to change { game.ended? }.from(false).to(true)
    end
  end

  context "when the dealer has blackjack" do
    before { allow(game.dealer_hand).to receive(:raw_value).and_return(21) }

    it "sets the dealer hand state to blackjack" do
      expect { subject }.to change { game.dealer_hand.blackjack? }.from(false).to(true)
    end

    it "should end the game" do
      expect { subject }.to change { game.ended? }.from(false).to(true)
    end
  end

  it "should set the state to playing" do
    expect(subject.game.playing?).to eq(true)
  end

  context "when there is no blackjack" do
    before do
      allow(game.player_hand).to receive(:value).and_return(20)
      allow(game.dealer_hand).to receive(:raw_value).and_return(20)
    end

    it "sets the player hand state to playing" do
      expect { subject }.to change { game.player_hand.playing? }.from(false).to(true)
    end
  end
end
