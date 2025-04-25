# frozen_string_literal: true

require_relative "game"

class GameController
  def initialize
    @game = Game.new
  end

  def start
    puts "戦争を開始します。"
    @game.deal_cards
    puts "カードが配られました。"
    loop do
      puts "戦争！"
      result = @game.compare_play_cards
      result[:cards].each_with_index do |card, i|
        puts "#{@game.players[i].name}のカードは#{card.mark}の#{card.display_number}です。"
      end

      if result[:result] == :win
        puts "#{result[:winner].name}が勝ちました。"
        break
      elsif result[:result] == :draw
        puts "引き分けです。"
      end
    end
    puts "戦争を終了します。"
  end
end
