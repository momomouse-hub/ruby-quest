# frozen_string_literal: true

class Player
  attr_accessor :name, :hand_cards, :won_card

  def initialize(name)
    @name = name
    @hand_cards = []
    @won_card = []
  end

  # インスタンス変数に直接アクセスする理由が特にないのであれば、アクセサメソッドを定義してreaderなのかwriterなのかaccessorなのか明示した方が読み手にとって優しいかなと思います！
  # （インスタンス変数に直接アクセスする方針にしていると、「どこかで書き込みするのかな？」と読み手に思わせてしまい、読み手のワーキングメモリをいたずらに消費してしまう。）
  def play_card
    if @hand_cards.any?
      play_card = @hand_cards.first
      @hand_cards.delete_at(0)
      play_card
    end
  end
end
