# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/game"
require_relative "../lib/player"
require_relative "../lib/card"

# Gameクラスのテストを行うクラスです
class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_game
    assert_equal 2, @game.players.size
    assert_equal "プレイヤー1", @game.players[0].name
    assert_equal "プレイヤー2", @game.players[1].name
    assert_equal 52, @game.deck.size
  end

  def test_game_deal_cards
    @game.deal_cards
    assert_equal 26, @game.players[0].hand_cards.size
    assert_equal 26, @game.players[1].hand_cards.size
  end

  def test_game_compare_play_cards_when_player1_have_strong_card
    @game.deck = []
    @game.players[0].hand_cards = [Card.new("ハート", 7)]
    @game.players[1].hand_cards = [Card.new("クラブ", 3)]

    result = @game.compare_play_cards

    assert_equal :win, result[:result]
    assert_equal @game.players[0], result[:winner]
    assert_equal 2, @game.players[0].won_card.size

    assert_equal "ハート", result[:cards][0].mark
    assert_equal 7, result[:cards][0].number
    assert_equal "クラブ", result[:cards][1].mark
    assert_equal 3, result[:cards][1].number
  end

  def test_game_compare_play_cards_when_player2_have_strong_card
    @game.deck = []
    @game.players[0].hand_cards = [Card.new("ハート", 3)]
    @game.players[1].hand_cards = [Card.new("クラブ", 7)]

    result = @game.compare_play_cards

    assert_equal :win, result[:result]
    assert_equal @game.players[1], result[:winner]
    assert_equal 2, @game.players[1].won_card.size

    assert_equal "ハート", result[:cards][0].mark
    assert_equal 3, result[:cards][0].number
    assert_equal "クラブ", result[:cards][1].mark
    assert_equal 7, result[:cards][1].number
  end

  def test_game_compare_play_cards_when_draw
    @game.deck = []
    @game.players[0].hand_cards = [Card.new("ハート", 5)]
    @game.players[1].hand_cards = [Card.new("クラブ", 5)]

    result = @game.compare_play_cards
    assert_equal :draw, result[:result]
    assert_equal 0, @game.players[0].won_card.size
    assert_equal 0, @game.players[1].won_card.size

    assert_equal "ハート", result[:cards][0].mark
    assert_equal 5, result[:cards][0].number
    assert_equal "クラブ", result[:cards][1].mark
    assert_equal 5, result[:cards][1].number
  end

  def test_both_players_have_hand_cards_when_players_have_cards
    @game.players[0].hand_cards = [Card.new("ハート", 5)]
    @game.players[1].hand_cards = [Card.new("スペード", 10)]

    result = @game.both_players_have_hand_cards?

    assert_equal :not_empty, result[:status]
  end

  def test_both_players_have_hand_cards_when_player_has_no_cards
    @game.players[0].hand_cards = []
    @game.players[1].hand_cards = [Card.new("スペード", 10)]

    result = @game.both_players_have_hand_cards?

    assert_equal :empty, result[:status]
    assert_includes result[:empty_player], @game.players[0]
  end

  def test_empty_player_have_won_cards_when_player_has_no_won_cards
    @game.players[0].hand_cards = []
    @game.players[0].won_card = []
    empty_players = [@game.players[0]]

    result = @game.empty_player_have_won_cards?(empty_players)

    assert_equal :lose, result[:status]
    assert_equal @game.players[0], result[:loser]
  end

  def test_empty_player_have_won_cards_when_player_has_won_cards
    @game.players[0].hand_cards = []
    @game.players[0].won_card = [Card.new("ハート", 5)]
    empty_players = [@game.players[0]]

    result = @game.empty_player_have_won_cards?(empty_players)

    assert_equal :continue, result[:status]
    assert_equal 1, @game.players[0].hand_cards.size
    assert_equal 0, @game.players[0].won_card.size
  end
end
