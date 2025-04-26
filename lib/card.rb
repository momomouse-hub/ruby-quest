# frozen_string_literal: true

class Card
  attr_accessor :mark, :number
  def initialize(mark, number)
    @mark = mark
    @number = number
  end
  def display_number
    case @number
    when 11 then "J"
    when 12 then "Q"
    when 13 then "K"
    when 14 then "A"
    when 15 then ""
    else @number.to_s
    end
  end
end
