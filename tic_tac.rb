
class Player
  attr_accessor :times_played

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @times_played = 0
  end

  def play(board, row, column)
    if (1..3).include?(row) && (1..3).include?(column)
      if board[row - 1][column - 1] != nil
        puts "Sorry bro this slot is already taken!"
      else
        board[row - 1][column - 1] = @symbol
        @times_played += 1
      end
    else
      puts "There's only 3 rows and columns honey..."
      puts "Please type a number between 1 and 3"
    end
    board
  end
end

class Board
  attr_accessor :board
  attr_reader :some_player_won, :is_full

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = Array.new(rows){Array.new(columns)}
    @some_player_won = false
    @is_full = false
  end

  def display_board
    @board.each do |row|
    p row
    end
  end

  def check_for_victory
    @board.transpose.each do |col|
      if col.join == "XXX"
        @some_player_won = true
        self.display_board
        puts "Player 1 wins!"
      elsif col.join == "OOO"
        @some_player_won = true
        self.display_board
        puts "Player 2 wins!"
      end
    end
    @board.each do |row|
      if row.join == "XXX"
        @some_player_won = true
        self.display_board
        puts "Player 1 wins!"
      elsif row.join == "OOO"
        @some_player_won = true
        self.display_board
        puts "Player 2 wins!"
      end
    end
   @board.each_with_index.reduce([]) do |memo, (row, index)|
      memo << row[index]
      if memo.join == "XXX"
        @some_player_won = true
        self.display_board
        puts "Player 1 wins!"
      elsif memo.join == "OOO"
        @some_player_won = true
        self.display_board
        puts "Player 2 wins!"
      end
      memo
    end
      if get_second_diagonale.join == "XXX"
        @some_player_won = true
        self.display_board
        puts "Player 1 wins!"
      elsif get_second_diagonale.join == "OOO"
        @some_player_won = true
        self.display_board
        puts "Player 2 wins!"
      end

  end

  def get_second_diagonale
    diago = []
    diago << @board[0][2]
    diago << @board[1][1]
    diago << @board[2][0]
    diago
  end

  def check_for_tie
    if @board.join.length == (@rows * @columns)  && !self.some_player_won
    @is_full = true
      self.display_board
      puts "It's a tie!"
    end
  end
end

class Gamed
player1 = Player.new("Player1", "X")
player2 = Player.new("Player2", "O")
tic_board = Board.new(3,3)

while(!tic_board.some_player_won && !tic_board.is_full)
  tic_board.display_board
  if player1.times_played == player2.times_played
    puts "Hey Player1 which row do you wanna play ?"
    row = gets.to_i
    puts "And on which column ?"
    column = gets.to_i
    player1.play(tic_board.board, row, column)
  elsif player1.times_played > player2.times_played
    puts "Hey Player2 which row do you wanna play ?"
    row = gets.to_i
    puts "And on which column ?"
    column = gets.to_i
    player2.play(tic_board.board, row, column)
  end
  tic_board.check_for_tie
  tic_board.check_for_victory
end
