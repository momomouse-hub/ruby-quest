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

    assert_equal "ハート", result[:cards][0].mark
    assert_equal 7, result[:cards][0].number
    assert_equal "クラブ", result[:cards][1].mark
    assert_equal 3, result[:cards][1].number
  end
end
