require 'pry'
class TicTacToe

  WIN_COMBINATIONS = [
    [3,4,5],
    [0,1,2],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
     puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
     puts "-----------"
     puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
     puts "-----------"
     puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
     input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    !(position_taken?(index)) && (0..8) === index
  end

  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Player, please enter a number 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    cp = current_player
    if valid_move?(index)
      move(index, cp)
      display_board
    else
      puts "I'm sorry, please select a valid number."
      turn
    end
  end

  def won?
    a = WIN_COMBINATIONS.find {
      |win_combo| @board[win_combo[0]] == "X" && @board[win_combo[1]] == "X" && @board[win_combo[2]] == "X"
    }
    b = WIN_COMBINATIONS.find {
      |win_combo| @board[win_combo[0]] == "O" && @board[win_combo[1]] == "O" && @board[win_combo[2]] == "O"
    }
    a || b
  end

  def full?
    @board.all? {|index| index == "X" || index == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if won?
      @board[won?[0]] == "X" ? "X" : "O"
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else draw?
      puts "Cat's Game!"
    end
  end

end
