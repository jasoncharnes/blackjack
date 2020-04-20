class CardComponent < ViewComponent::Base
  def initialize(card:)
    @card = card
  end

  def rank
    return "A" if @card.ace?
    return face if @card.face?
    @card.rank
  end

  def suit
    content_tag :i, nil, class: "fas fa-#{@card.suit} fa-fw"
  end

  private

  def face
    Card::FACES.key(@card.rank).to_s.first.capitalize
  end
end
