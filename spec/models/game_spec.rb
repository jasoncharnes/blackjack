require "rails_helper"

RSpec.describe Game, type: :model do
  describe "callbacks" do
    describe "after create" do
      it "should generate a deck of cards" do
        expect { create(:game) }.to change { Card.count }.by(52)
      end

      it "should generate two hands" do
        expect { create(:game) }.to change { Hand.count }.by(2)

        expect(Hand.first).to be_dealer
        expect(Hand.last).to_not be_dealer
      end
    end
  end
end
