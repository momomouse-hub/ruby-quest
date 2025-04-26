# frozen_string_literal: true

class Game
  require_relative "player"
  require_relative "card"

  attr_reader :players
  attr_accessor :deck

  def initialize
    @players = create_player
    @deck = create_deck
  end

  def create_player
    players = []
    for i in 1..2 do
      player = Player.new("プレイヤー#{i}")
      players << player
    end
    players
  end

  def create_deck
    deck = []
    marks = ["ハート", "ダイヤ", "スペード", "クラブ"]
    numbers = (2..14).to_a
    marks.each do |mark|
      numbers.each do |number|
        deck << Card.new(mark, number)
      end
    end
    deck.shuffle!
  end

  def deal_cards
    first_half = @deck.slice(0...@deck.size / 2)
    second_half = @deck.slice((@deck.size / 2)...@deck.size)
    @players[0].hand_cards = first_half
    @players[1].hand_cards = second_half
    @deck = []
  end

  def compare_play_cards
    player1 = @players[0]
    player2 = @players[1]
    cards = [player1.play_card, player2.play_card]
    @deck.concat(cards)
    if cards[0].number > cards[1].number
      player1.won_card.concat(@deck)
      { result: :win, winner: player1, cards: cards }
    elsif cards[0].number < cards[1].number
      player2.won_card.concat(@deck)
      { result: :win, winner: player2, cards: cards }
    else
      { result: :draw, cards: cards }
    end
  end
end
