# frozen_string_literal: true

require_relative "game"

class GameController
  def initialize
    @game = Game.new
  end

  def start
    display_game_start_message
    setup_players
    @game.deal_cards
    display_deal_cards_message

    players = @game.players

    loop do
      hand_cards_status = @game.all_players_have_hand_cards?

      if hand_cards_status[:status] == :empty
        empty_player = hand_cards_status[:empty_player]
        won_cards_status = @game.empty_player_have_won_cards?(empty_player)

        if won_cards_status[:status] == :lose
          display_empty_player_exist(won_cards_status[:loser])
          break
        end
      end

      display_war_massage
      result = @game.compare_play_cards(players)
      display_compare_result(result, players)

      if result[:result] == :win
        players = @game.players
      elsif result[:result] == :draw
        players = result[:players]
      end
    end
    merge_won_cards_into_hand_cards
    display_hand_cards_and_ranking
    display_game_end_message
  end

  private
    def display_game_start_message
      puts "戦争を開始します。"
    end

    def setup_players
      print "プレイヤーの人数を入力してください(2〜5)："
      player_count = gets.to_i
      until player_count.between?(2, 5)
        print "不正な値が入力されました。2〜5の数字を入力してください:"
        player_count = gets.to_i
      end

      @game.players = []

      player_count.times do |i|
        print "プレイヤー#{i + 1}の名前を入力してください："
        name = gets.chomp
        @game.players << Player.new(name)
      end
    end

    def display_deal_cards_message
      puts "カードが配られました。"
    end

    def display_war_massage
      puts "戦争！"
    end

    def display_compare_result(result, players)
      players.zip(result[:cards]).each do |player, card|
        next if player.nil? || card.nil?
        puts "#{player.name}のカードは#{card.mark}の#{card.display_number}です。"
      end
      puts make_result_massage(result)
    end

    def make_result_massage(result)
      case result[:result]
      when :win
        "#{result[:winner].name}が勝ちました。#{result[:winner].name}はカードを#{result[:won_card_count]}枚もらいました。"
      when :draw
        "引き分けです。"
      end
    end

    def display_empty_player_exist(loser)
      puts "#{loser.name}の手札がなくなりました。"
    end

    def merge_won_cards_into_hand_cards
      @game.players.each do |player|
        player.hand_cards.concat(player.won_card)
        player.won_card = []
      end
    end

    def display_hand_cards_and_ranking
      hand_cards_message = @game.players.map do |player|
        "#{player.name}の手札の枚数は#{player.hand_cards.size}枚です。"
      end.join("")
      puts "#{hand_cards_message}"

      result = @game.players.sort_by { |player| player.hand_cards.size }.reverse
      ranking_message = result.map.with_index do |player, index|
        "#{player.name}が#{index + 1}位"
      end.join("、")
      puts "#{ranking_message}です。"
    end

    def display_game_end_message
      puts "戦争を終了します。"
    end
end
