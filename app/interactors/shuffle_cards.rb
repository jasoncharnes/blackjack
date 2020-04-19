class ShuffleCards
  include Interactor

  def call
    Card.import!(
      shuffled_cards_for_import,
      on_duplicate_key_update: {conflict_target: [:id], columns: [:position]}
    )
  end

  private

  def shuffled_cards_for_import
    context.cards.shuffled.map.with_index do |card, index|
      card.tap { |c| c.position = index }
    end
  end
end
