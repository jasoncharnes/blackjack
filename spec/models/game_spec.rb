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

  describe "result" do
    let(:dealer_hand) { build(:hand) }
    let(:hand) { build(:hand) }
    let(:game) { build(:game, dealer_hand: dealer_hand) }

    subject { game.result(hand) }

    context "when the hand is busted" do
      it "should return :bust" do
        allow(hand).to receive(:busted?).and_return(true)
        expect(subject).to eq(:bust)
      end
    end

    context "when the hand is not busted and the dealer's hand is busted" do
      it "should return :win" do
        allow(hand).to receive(:busted?).and_return(false)
        allow(dealer_hand).to receive(:busted?).and_return(true)
        expect(subject).to eq(:win)
      end
    end

    context "when no one has busted" do
      context "and the hand is greater than the dealer's hand" do
        it "should return :win" do
          allow(hand).to receive(:value).and_return(18)
          allow(dealer_hand).to receive(:value).and_return(17)
          expect(subject).to eq(:win)
        end
      end

      context "and the hand is the same value as the dealer's hand" do
        it "should return :push" do
          allow(hand).to receive(:value).and_return(18)
          allow(dealer_hand).to receive(:value).and_return(18)
          expect(subject).to eq(:push)
        end
      end

      context "and the hand is less than the dealer's hand" do
        it "should return :loss" do
          allow(hand).to receive(:value).and_return(18)
          allow(dealer_hand).to receive(:value).and_return(19)
          expect(subject).to eq(:loss)
        end
      end
    end
  end
end
