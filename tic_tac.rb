class Player
  attr_accessor :times_played

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @times_played = 0
  end

  def valid_input?(row, column)
    (1..3).include?(row) && (1..3).include?(column)
  end

  def play(board, row, column)
    if valid_input?(row, column)
      if board[row - 1][column - 1].nil?
        board[row - 1][column - 1] = @symbol
        @times_played += 1
      else
        puts 'Sorry honey this slot is taken already...'
      end
    else
      puts 'Hoo darling, please type a number between 1 and 3...'
    end
  end
end

class Board
  attr_accessor :board
  attr_reader :game_over

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = Array.new(rows) { Array.new(columns) }
    @game_over = false
  end

  def display_board
    @board.each do |row|
      p row
    end
  end

  def game_over_message(message)
    @game_over = true
    display_board
    puts message
  end

  def columns_values
    columns = []
    @board.transpose.each do |col|
      columns << col.join
    end
    columns
  end

  def rows_values
    rows = []
    @board.each do |row|
      rows << row.join
    end
    rows
  end

  def diagonal1
    column = 0
    @board.each_with_object([]) do |row, array|
      array << row[column]
      column += 1
    end
  end

  def diagonal2
    column = 2
    @board.each_with_object([]) do |row, array|
      array << row[column]
      column -= 1
    end
  end

  def board_values
    board_values = []
    board_values << columns_values
    board_values << rows_values
    board_values << diagonal1.join
    board_values << diagonal2.join
    board_values.flatten
  end

  def game_over?
    if board_values.include?('XXX')
      game_over_message('Congratulations player1 you won!!!')
    elsif board_values.include?('OOO')
      game_over_message('Congratulations player2 you won!!!')
    elsif @board.join.length == (@rows * @columns)
      game_over_message("Well done babes! it's a tie!!!")
    end
  end
end

player1 = Player.new('Player 1', 'X')
player2 = Player.new('Player 2', 'O')
tic_board = Board.new(3, 3)

until tic_board.game_over
  tic_board.display_board
  if player1.times_played == player2.times_played
    puts 'Hey Player1 which row do you wanna play ?'
    row = gets.to_i
    puts 'And on which column ?'
    column = gets.to_i
    player1.play(tic_board.board, row, column)
  else
    puts 'Hey Player2 which row do you wanna play ?'
    row = gets.to_i
    puts 'And on which column ?'
    column = gets.to_i
    player2.play(tic_board.board, row, column)
  end
  tic_board.game_over?
end
