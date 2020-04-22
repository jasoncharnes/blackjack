require "rails_helper"

RSpec.describe ShuffleCards, type: :interactor do
  let(:game) { create(:game) }

  before { create_list(:card, 2, game: game) }

  subject { described_class.call(cards: game.cards) }

  it "shuffles the cards" do
    expect { subject }.to change { game.cards.order_by_position.pluck(:position) }
  end
end
