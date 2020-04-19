require "rails_helper"

RSpec.describe BuildCardDeck, type: :interactor do
  subject { described_class.call }

  it "should generate 52 cards" do
    expect(subject.cards.count).to eq(52)
  end
end
