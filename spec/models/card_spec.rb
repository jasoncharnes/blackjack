require "rails_helper"

RSpec.describe Card, type: :model do
  describe "DECK_GENERATOR" do
    subject { Card::DECK_GENERATOR.call }

    it "should contain a 52 card hash" do
      expect(subject.count).to eq(52)
    end

    it "should have all the ranks" do
      grouped_cards = subject.group_by { |card| card[:rank] }
      expect(grouped_cards.count).to eq(Card::RANKS.count)
    end

    it "should have all the suits" do
      grouped_cards = subject.group_by { |card| card[:suit] }
      expect(grouped_cards.count).to eq(Card::SUITS.count)
    end
  end

  describe "#ace?" do
    context "when rank is one" do
      it "should return true" do
        subject.rank = 1
        expect(subject.ace?).to eq(true)
      end
    end

    context "when rank is not one" do
      it "should return false" do
        subject.rank = 2
        expect(subject.ace?).to eq(false)
      end
    end
  end

  describe "#face?" do
    context "when rank is in the face values" do
      it "should return true" do
        subject.rank = Card::FACES.values.first
        expect(subject.face?).to eq(true)
      end
    end

    context "when rank is in not in the face values" do
      it "should return false" do
        subject.rank = -1
        expect(subject.face?).to eq(false)
      end
    end
  end

  describe "#hide!" do
    it "should change visible to false" do
      card = create(:card)
      expect { card.hide! }.to change { card.visible? }.from(true).to(false)
    end
  end

  describe "#value?" do
    it "should return the rank" do
      subject.rank = 5
      expect(subject.value).to eq(5)
    end

    context "when the card is an ace" do
      it "should return 11" do
        allow(subject).to receive(:ace?) { true }
        expect(subject.value).to eq(11)
      end
    end

    context "when the card is a face card" do
      it "should return 10" do
        allow(subject).to receive(:face?) { true }
        expect(subject.value).to eq(10)
      end
    end
  end
end
