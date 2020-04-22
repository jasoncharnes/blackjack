class CardComponent < ViewComponent::Base
  delegate :visible?, to: :@card

  def initialize(card:)
    @card = card
  end

  def card_color
    @card.suit.in?(["diamond", "heart"]) ? "text-red-600" : "text-black"
  end

  def rank
    return "A" if @card.ace?
    return face if @card.face?
    @card.rank
  end

  def suit(size: "")
    content_tag :i, nil, class: "fas fa-#{@card.suit} fa-fw #{size}"
  end

  private

  def face
    Card::FACES.key(@card.rank).to_s.first.capitalize
  end
end
