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
end
