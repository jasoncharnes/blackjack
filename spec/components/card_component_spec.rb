require "rails_helper"

RSpec.describe CardComponent, type: :component do
  let(:card) { build(:card) }

  describe "#rank" do
    subject { described_class.new(card: card).rank }

    it "should return an integer" do
      allow(card).to receive(:rank).and_return(5)
      expect(subject).to eq(5)
    end

    context "as an ace" do
      it "should return A" do
        allow(card).to receive(:ace?).and_return(true)
        expect(subject).to eq("A")
      end
    end

    context "as a face card" do
      it "should return J" do
        allow(card).to receive(:rank).and_return(11)
        expect(subject).to eq("J")
      end

      it "should return Q" do
        allow(card).to receive(:rank).and_return(12)
        expect(subject).to eq("Q")
      end

      it "should return K" do
        allow(card).to receive(:rank).and_return(13)
        expect(subject).to eq("K")
      end
    end
  end

  describe "#suit" do
    subject { described_class.new(card: card).suit }

    it "should return a font-awesome icon for the given suit" do
      allow(card).to receive(:suit) { :club }
      expect(subject).to eq("<i class=\"fas fa-club fa-fw \"></i>")
    end
  end

  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class.new(attr: "value")) { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end
