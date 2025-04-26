# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/card"

# Cardクラスのテストを行うクラスです
class CardTest < Minitest::Test
  def setup
    @card1 = Card.new("ハート", 14)
    @card2 = Card.new("スペード", 2)
    @card11 = Card.new("クラブ", 11)
    @card12 = Card.new("ダイヤ", 12)
    @card13 = Card.new("ハート", 13)
  end

  def test_card
    assert_equal "ハート", @card1.mark
    assert_equal 14, @card1.number
  end

  def test_card_display_card
    assert_equal "A", @card1.display_number
    assert_equal "2", @card2.display_number
    assert_equal "J", @card11.display_number
    assert_equal "Q", @card12.display_number
    assert_equal "K", @card13.display_number
  end
end
