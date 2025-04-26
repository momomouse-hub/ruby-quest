# frozen_string_literal: true

class Player
  attr_accessor :name, :hand_cards, :won_card
  def initialize(name)
    @name = name
    @hand_cards = []
    @won_card = []
  end
  def play_card
    if @hand_cards.any?
      play_card = @hand_cards.first
      @hand_cards.delete_at(0)
      play_card
    end
  end
end
