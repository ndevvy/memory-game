require_relative 'board.rb'
require_relative 'player.rb'

class Game

  MAX_TURN_COUNT = 1000

  attr_reader :player
  attr_accessor :board, :current_guess, :previous_guess

  def initialize(board = Board.new, player = HumanPlayer.new)
    @board = board
    @player = player
  end

  def play
    board.populate
    @turn_count = 0

    until (won? || @turn_count > MAX_TURN_COUNT)


      player_turn

      sleep(3)
     system("clear")

      clean_board
      reset_guesses

      @turn_count += 1
    end

    puts "Game Over! #{outcome}"
  end

  def outcome
    if won?
      return "You Win!"
    else
      "You Suck!"
    end
  end

  def won?
    board.won?
  end

  def player_turn
    puts "Turns remaining: #{MAX_TURN_COUNT - @turn_count}"
    board.display
    @guess_count = 0
    2.times do
      player.prompt
      pos = player.get_guess(@guess_count)
      manage_guess(pos)
      @guess_count += 1
      board.display
    end
  end

  def manage_guess(pos) #clean this up
    board.reveal(pos)
    player.receive_revealed_card(pos, board[pos].val)
    if self.current_guess == nil
      self.current_guess = pos
    else
      self.previous_guess = self.current_guess
      self.current_guess = pos
    end
  end

  def reset_guesses
    self.previous_guess = nil
    self.current_guess = nil
    @guess_count = 0
  end

  def clean_board
    unless board[self.previous_guess].val == board[self.current_guess].val
      board.hide(self.previous_guess)
      board.hide(self.current_guess)
    end
  end

end


if $PROGRAM_NAME == __FILE__
  game = Game.new()
  game.play
end
