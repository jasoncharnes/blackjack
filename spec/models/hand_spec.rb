require "rails_helper"

RSpec.describe Hand, type: :model do
  describe "#draw!" do
    it "should add a card to the hand" do
      hand = create(:hand)
      card = create(:card)

      expect { hand.draw!(card: card) }.to change { card.hand }.from(nil).to(hand)
    end
  end
end
