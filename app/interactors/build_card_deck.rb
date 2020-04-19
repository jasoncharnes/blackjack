class BuildCardDeck
  include Interactor

  def call
    generated_cards = Card::SUITS.map { |suit|
      Card::RANKS.map do |rank|
        Card.new(rank: rank, suit: suit)
      end
    }

    context.cards = generated_cards.flatten
  end
end
