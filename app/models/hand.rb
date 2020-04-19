class Hand < ApplicationRecord
  belongs_to :game
  has_many :cards

  scope :dealer, -> { where(dealer: true) }
  scope :player, -> { where(dealer: false) }

  def draw!(card:)
    cards << card
  end
end
