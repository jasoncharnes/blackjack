# frozen_string_literal: true

class GameReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com
  def start
    ::ResetGame.call(game: game)
    ::ShuffleCards.call(cards: game.cards)
    ::DealGame.call(game: game)
    ::StartGame.call(game: game)
  end

  def hit
    ::Hand::Hit.call(hand: game.player_hand)

    if game.player_hand.busted?
      ::Hand::PlayDealer.call(hand: game.dealer_hand)
    end
  end

  def stand
    game.player_hand.stand!
    ::Hand::PlayDealer.call(hand: game.dealer_hand)
  end

  private

  def game
    @game ||= begin
      Game
        .includes(:cards, hands: :cards)
        .find_or_create_by(session_id: session.id.to_s)
    end
  end
end
