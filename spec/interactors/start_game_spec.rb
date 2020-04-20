require "rails_helper"

RSpec.describe StartGame, type: :interactor do
  let(:game) { create(:game) }

  subject { described_class.call(game: game) }

  context "when the player has blackjack" do
    before { allow(game.player_hand).to receive(:value).and_return(21) }

    it "sets the player hand state to blackjack" do
      expect { subject }.to change { game.player_hand.blackjack? }.from(false).to(true)
    end
  end

  context "when the player doesn't have blackjack" do
    before { allow(game.player_hand).to receive(:value).and_return(20) }

    it "sets the player hand state to playing" do
      expect { subject }.to change { game.player_hand.playing? }.from(false).to(true)
    end
  end

  it "should set the state to playing" do
    expect(subject.game.playing?).to eq(true)
  end
end
