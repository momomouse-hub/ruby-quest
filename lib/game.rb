# frozen_string_literal: true

class Game
  require_relative "player"
  require_relative "card"

  attr_accessor :deck, :players

  def initialize
    @players = []
    @deck = create_deck
  end

  # def create_player
  #   players = []
  #   for i in 1..2 do
  #     player = Player.new("プレイヤー#{i}")
  #     players << player
  #   end
  #   players
  # end

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
    @deck.each_with_index do |card, index|
      player = @players[index % @players.size]
      player.hand_cards << card
    end
    @deck = []
  end

  def all_players_have_hand_cards?
    empty_player = @players.select { |player| player.hand_cards.empty? }
    if empty_player.empty?
      { status: :not_empty }
    else
      { status: :empty, empty_player: empty_player }
    end
  end

  def empty_player_have_won_cards?(empty_player)
    empty_player.each do |player|
      if player.won_card.empty?
        return { status: :lose, loser: player }
      else
        player.hand_cards.concat(player.won_card.shuffle!)
        player.won_card = []
      end
    end
    { status: :continue }
  end

  def compare_play_cards(players)
    cards = []
    players.each do |player|
      cards << player.play_card
    end
    @deck.concat(cards)
    strongest_number = cards.map(&:number).max
    strongest_indices = cards.each_index.select { |i| cards[i].number == strongest_number }

    if strongest_indices.size == 1
      won_card_count = @deck.size
      winner = players[strongest_indices[0]]
      winner.won_card.concat(@deck)
      @deck = []
      { result: :win, winner: winner, cards: cards, won_card_count: won_card_count }
    else
      next_players = strongest_indices.map {|i| players[i]}
      { result: :draw, cards: cards, players: next_players }
    end
  end
end
