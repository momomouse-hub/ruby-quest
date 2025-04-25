# frozen_string_literal: true

class Player
  attr_accessor :name, :hand_card, :won_card
  def initialize(name)
    @name = name
    @hand_card = []
    @won_card = []
  end
  def play_card
    if @hand_card.any?
      play_card = @hand_card.first
      @hand_card.delete_at(0)
      play_card
    end
  end
end
