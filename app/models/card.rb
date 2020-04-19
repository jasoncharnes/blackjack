class Card
  include ActiveModel::Model

  RANKS = 1..13
  SUITS = ["club", "diamond", "heart", "spade"]

  attr_accessor :rank, :suit
end
