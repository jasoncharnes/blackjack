require "rails_helper"

RSpec.describe Hand::PlayDealer, type: :interactor do
  let(:hand) { create(:hand) }

  before { create_list(:card, 4, game: hand.game) }

  subject { described_class.call(hand: hand) }

  it "plays the hand" do
    expect(hand).to receive(:play!)
    subject
  end

  it "makes all cards visible" do
    expect { subject }.to change { hand.cards.visible.count }
  end

  it "will stand when the value 17 or greater" do
    allow(hand).to receive(:value).and_return(17)
    expect { subject }.to change { hand.stood? }.from(false).to(true)
  end

  it "will play until stand or bust" do
    expect { subject }.to change { hand.stood? || hand.busted? }.from(false).to(true)
  end

  it "ends the game" do
    expect { subject }.to change { hand.game.ended? }.from(false).to(true)
  end
end
