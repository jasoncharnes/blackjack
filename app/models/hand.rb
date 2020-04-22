class Hand < ApplicationRecord
  include WorkflowActiverecord

  workflow do
    state :waiting do
      event :play, transitions_to: :playing
      event :blackjack, transitions_to: :blackjack
    end

    state :playing do
      event :bust, transitions_to: :busted
      event :stand, transitions_to: :stood
    end

    state :blackjack
    state :busted
    state :stood
  end

  belongs_to :game
  has_many :cards, -> { order_by_position }

  scope :dealer, -> { where(dealer: true) }
  scope :player, -> { where(dealer: false) }

  def draw!(card:)
    cards << card
  end

  def raw_value
    cards.sum(&:value)
  end

  def value
    cards
      .select(&:ace?)
      .reduce(visible_value) { |sum, _card| sum > 21 ? sum - 10 : sum }
  end

  private

  def visible_value
    cards.visible.sum(&:value)
  end
end
