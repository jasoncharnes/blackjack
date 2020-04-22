class CardComponentPreview < ViewComponent::Preview
  def face_card
    card = FactoryBot.build(:card, :face)
    render(CardComponent.new(card: card))
  end

  def ace_card
    card = FactoryBot.build(:card, :ace)
    render(CardComponent.new(card: card))
  end

  def rank_card
    card = FactoryBot.build(:card, :rank)
    render(CardComponent.new(card: card))
  end

  def side_by_side
    cards = FactoryBot.build_list(:card, 2)
    render(CardComponent.with_collection(cards))
  end

  def dealer_hand
    cards = [FactoryBot.build(:card), FactoryBot.build(:card, :hidden)]
    render(CardComponent.with_collection(cards))
  end
end
