# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/player"
require_relative "../lib/card"

# Playerクラスのテストを行うクラスです
class PlayerTest < Minitest::Test
  def setup
    @player = Player.new("プレイヤー1")
  end

  def test_player
    assert_equal "プレイヤー1", @player.name
    assert_equal [], @player.hand_cards
    assert_equal [], @player.won_card
  end

  def test_player_play_card
    assert_nil @player.play_card

    card = Card.new("ハート", 5)
    @player.hand_cards << card

    played_card = @player.play_card

    assert_equal card, played_card
    assert_equal 0, @player.hand_cards.size
  end
end
