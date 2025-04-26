# frozen_string_literal: true

require_relative "game"

class GameController
  def initialize
    @game = Game.new
  end

  def start
    display_game_start_message
    @game.deal_cards
    display_deal_cards_message

    loop do
      display_war_massage
      result = @game.compare_play_cards
      display_compare_result(result)

      break if result[:result] == :win
    end

    display_game_end_message
  end

  private
    def display_game_start_message
      puts "戦争を開始します。"
    end

    def display_deal_cards_message
      puts "カードが配られました。"
    end

    def display_war_massage
      puts "戦争！"
    end

    def display_compare_result(result)
      result[:cards].each_with_index do |card, i|
        puts "#{@game.players[i].name}のカードは#{card.mark}の#{card.display_number}です。"
      end

      puts make_result_massage(result)
    end

    def make_result_massage(result)
      case result[:result]
      when :win
        "#{result[:winner].name}が勝ちました。"
      when :draw
        "引き分けです。"
      end
    end

    def display_game_end_message
      puts "戦争を終了します。"
    end
end
