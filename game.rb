class Game
  require_relative 'player'
  require_relative 'card'

  attr_reader :players

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
    deck.shuffle
  end
  def deal_cards
    first_half = @deck.slice(0...@deck.size/2)
    second_half = @deck.slice((@deck.size/2)...@deck.size)
    @players[0].hand_card = first_half
    @players[1].hand_card = second_half
  end
  def compare_play_cards
    loop do
      puts "戦争！"
      player1 = @players[0]
      player2 = @players[1]
      card1 = player1.play_card
      card2 = player2.play_card
      puts "#{player1.name}のカードは#{card1.mark}の#{card1.display_number}です。"
      puts "#{player2.name}のカードは#{card2.mark}の#{card2.display_number}です。"
      if card1.number > card2.number
        player1.won_card << card1
        player1.won_card << card2
        puts "#{player1.name}が勝ちました。\n戦争を終了します。"
        break
      elsif card1.number < card2.number
        player2.won_card << card1
        player2.won_card << card2
        puts "#{player2.name}が勝ちました。\n戦争を終了します。"
        break
      else
        puts "引き分けです。"
      end
    end
  end
end

game = Game.new
game.deal_cards
game.compare_play_cards