# frozen_string_literal: true

require "minitest/autorun"
require "stringio"
require_relative "../lib/game_controller"

# GameControllerクラスのテストを行うクラスです
class GameControllerTest < Minitest::Test
  def setup
    @game_controller = GameController.new
  end

  def test_start_outputs_messages
    output = StringIO.new
    $stdout = output

    @game_controller.start

    output.rewind
    all_output = output.read

    assert_includes all_output, "戦争を開始します。"
    assert_includes all_output, "カードが配られました。"
    assert_includes all_output, "戦争！"
    assert_includes all_output, "戦争を終了します。"
    assert_match(/プレイヤー\dの手札の枚数は\d+枚です。/, all_output)
    assert_match(/プレイヤー\dが1位、プレイヤー\dが2位です。/, all_output)

  ensure
    $stdout = STDOUT
  end
end
