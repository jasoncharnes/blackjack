require "rails_helper"

RSpec.describe Hand, type: :model do
  describe "#draw!" do
    it "should add a card to the hand" do
      hand = create(:hand)
      card = create(:card)

      expect { hand.draw!(card: card) }.to change { card.hand }.from(nil).to(hand)
    end
  end

  describe "#value" do
    it "should add up the cards" do
      hand = build(:hand, cards: build_list(:card, 2, rank: 5))
      expect(hand.value).to eq(10)
    end

    context "with an ace" do
      it "should use the higher ace value" do
        hand = build(:hand, cards: [build(:card, :ace), build(:card, rank: 10)])
        expect(hand.value).to eq(21)
      end
    end

    context "with two aces" do
      it "should use one high and one low ace value" do
        hand = build(:hand, cards: build_list(:card, 2, :ace))
        expect(hand.value).to eq(12)
      end
    end

    context "with two aces and a 5" do
      it "should use one high ace, one low ace, and the 5" do
        hand = build(:hand, cards: [build(:card, :ace), build(:card, :ace), build(:card, rank: 5)])
        expect(hand.value).to eq(17)
      end
    end
  end
end
