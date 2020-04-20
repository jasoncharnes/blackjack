require "rails_helper"

RSpec.describe Game, type: :model do
  describe "workflow states" do
    describe "playing" do
      let!(:game) { create(:game) }

      it "is playing by default" do
        expect(game.playing?).to eq(true)
      end

      it "can transition to ended" do
        expect { game.end! }.to change { game.workflow_state }.from("playing").to("ended")
      end
    end

    describe "ended" do
      let!(:game) { create(:game, :ended) }

      it "can transition to playing" do
        expect { game.play! }.to change { game.workflow_state }.from("ended").to("playing")
      end
    end
  end

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
