require_relative 'card.rb'

class Board
  SYM_ARY = ('a'..'z').to_a

  attr_reader :grid
  #consider board size
  def initialize
    @grid = Array.new(6) { Array.new(6)}
  end

  def populate(cards = deck)
    grid.size.times do |j|
      grid[0].size.times do |k|
        grid[j][k] = cards.shift
      end
    end
  end

  def card_count
    count = Hash.new(0)
    deck.each do |card|
      count[card.val] += 1
    end

    count
  end

  #REFACTOR
  def deck(sym_ary = SYM_ARY)
    sym_sample = sym_ary.sample(symbols_needed)
    deck = sym_sample.concat(sym_sample).shuffle

    deck.map { |sym| Card.new(sym) }
  end

  def symbols_needed
    ( grid.size * grid[0].size ) / 2
  end

  def display
    grid.each do |row|
      puts row.map { |el| el.visible? ? el.to_s : "?" }.join(" ")
    end
  end

  def won? #check whether all cards have ben revealed
    grid.each do |row|
      row.each do |card|
        return false unless card.visible?
      end
    end
    true
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal
  end

  def hide(guessed_pos)
    self[guessed_pos].hide
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end
end
