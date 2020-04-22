require "rails_helper"

RSpec.describe Hand::Hit, type: :interactor do
  let(:hand) { create(:hand, :playing) }

  before { create(:card, game: hand.game) }

  subject { described_class.call(hand: hand) }

  it "draws the next card into the hand" do
    expect { subject }.to change { hand.cards.count }.by(1)
  end

  it "bust if the new value is greater than 21" do
    allow(hand).to receive(:value).and_return(22)
    expect { subject }.to change { hand.busted? }.from(false).to(true)
  end
end
