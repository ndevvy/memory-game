require 'byebug'
class HumanPlayer

  def initialize
  end

  def prompt
    puts "enter your guess ('1, 2')"
  end

  def get_guess(board)
    guess = gets.chomp
    [guess[0].to_i, guess[-1].to_i]
  end

  def receive_revealed_card(pos, val)
  end

  def receive_match(pos1, pos2)
  end

end

class ComputerPlayer

attr_accessor :known_cards, :matched_cards, :candidates, :matched_vals

  def initialize
    @known_cards = {}
    @matched_cards = []
    @candidates = load_candidates
    @matched_vals = {}
  end

  def load_candidates
    positions = []
    6.times do |j|
      6.times do |k|
        positions.push [j, k]
      end
    end
    positions
  end

  def delete_candidate(pos)
    self.candidates.reject! { |spot| spot == pos }
  end

  def prompt
    p "My known cards: #{self.known_cards}"
  end

  def random_guess
    guess = self.candidates.sample
    delete_candidate(guess)
    guess
  end

  def get_guess(guess_count)
      p self.matched_cards
    if !self.matched_cards.empty?
      p "Guessing matched cards: Guess no. #{guess_count}"
      guess = self.matched_cards.pop
      if guess_count == 1
        self.matched_cards = []
      end

      guess
    else
      p "This is a random guess: Guess no. #{guess_count}"
      random_guess
    end
  end

  def receive_revealed_card(pos, val)
    if new_match?(val)
      p "I found a match!"
      receive_match(self.known_cards.key(val), pos)
      self.matched_vals[val] = true
    else
      p "Loading known position #{pos} as #{val}"
      self.known_cards[pos] = val
    end
      p "Matched values: #{self.matched_vals}"
  end

  def new_match?(val)
    self.known_cards.values.include?(val) && !self.matched_vals.include?(val)
  end

  def receive_match(pos1, pos2)
    #ordered to work on both guess counts
    self.matched_cards = [pos2, pos1]
  end

end
