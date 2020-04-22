require "rails_helper"

RSpec.describe Hand, type: :model do
  describe "workflow states" do
    describe "waiting" do
      let!(:hand) { create(:hand) }

      it "is waiting by default" do
        expect(hand.waiting?).to eq(true)
      end

      it "can transition to playing" do
        expect { hand.play! }.to change { hand.workflow_state }.from("waiting").to("playing")
      end
    end

    describe "playing" do
      let!(:hand) { create(:hand, :playing) }

      it "can transition to busted" do
        expect { hand.bust! }.to change { hand.workflow_state }.from("playing").to("busted")
      end

      it "can transition to stood" do
        expect { hand.stand! }.to change { hand.workflow_state }.from("playing").to("stood")
      end
    end
  end

  describe "#draw!" do
    it "should add a card to the hand" do
      hand = create(:hand, :playing)
      card = create(:card, game: hand.game)

      expect { hand.draw!(card: card) }.to change { card.hand }.from(nil).to(hand)
    end
  end

  describe "#raw_value" do
    context "with a hidden card" do
      it "should include the value" do
        hand = create(:hand, cards: [build(:card, :hidden, rank: 5), build(:card, rank: 5)])
        expect(hand.raw_value).to eq(10)
      end
    end
  end

  describe "#value" do
    it "should add up the cards" do
      hand = create(:hand, cards: build_list(:card, 2, rank: 5))
      expect(hand.value).to eq(10)
    end

    context "with an ace" do
      it "should use the higher ace value" do
        hand = create(:hand, cards: [build(:card, :ace), build(:card, rank: 10)])
        expect(hand.value).to eq(21)
      end
    end

    context "with two aces" do
      it "should use one high and one low ace value" do
        hand = create(:hand, cards: build_list(:card, 2, :ace))
        expect(hand.value).to eq(12)
      end
    end

    context "with one ace and three nines" do
      it "should use the low ace, but still be greater than twenty-one" do
        hand = create(:hand, cards: [build(:card, :ace), build_list(:card, 3, rank: 9)].flatten)
        expect(hand.value).to eq(28)
      end
    end

    context "with two aces and one ten" do
      it "should use two low aces and the ten" do
        hand = create(:hand, cards: [build_list(:card, 2, :ace), build(:card, rank: 10)].flatten)
        expect(hand.value).to eq(12)
      end
    end

    context "with two aces and a five" do
      it "should use one high ace, one low ace, and the five" do
        hand = create(:hand, cards: [build(:card, :ace), build(:card, :ace), build(:card, rank: 5)])
        expect(hand.value).to eq(17)
      end
    end
  end
end
