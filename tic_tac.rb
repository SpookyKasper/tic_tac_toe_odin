class Player
  attr_reader :name, :symbol, :times_played

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @times_played = 0
  end

  def choose_slot
    choosen_slot = []
    puts "Hey #{@name} which row do you wann play?"
    choosen_slot << gets.to_i - 1
    puts 'And on wich column?'
    choosen_slot << gets.to_i - 1
    choosen_slot
  end

  def play(board, slot)
    row = slot[0]
    column = slot[1]
    board[row][column] = @symbol
    @times_played += 1
  end
end

class Board
  attr_accessor :board
  attr_reader :rows, :columns

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

  def slot_free?(slot)
    row = slot[0]
    column = slot[1]
    @board[row][column].nil?
  end
end

class TicTacToeGame
  def initialize(player1, player2)
    @player1 = Player.new(player1, 'X')
    @player2 = Player.new(player2, 'O')
    @board = Board.new(3, 3)
    @game_over = false
  end

  def who_plays?
    @player1.times_played == @player2.times_played ? @player1 : @player2
  end

  def valid_input?(slot)
    (0..2).include?(slot[0]) && (0..2).include?(slot[1])
  end

  def game_over_message(message)
    @game_over = true
    @board.display_board
    puts message
  end

  def game_over?
    if @board.board_values.include?('XXX')
      game_over_message("Congratulaions #{@player1.name} you won!!!")
    elsif @board.board_values.include?('OOO')
      game_over_message("Congratulations #{@player2.name} you won!!!")
    elsif @board.board.join.length == (@board.rows * @board.columns)
      game_over_message("Well done babes! it's a tie!!!")
    end
  end

  def slot_is_taken
    puts 'Sorry babe slot is taken...'
  end

  def game_on
    player = who_plays?
    slot = player.choose_slot
    if valid_input?(slot)
      @board.slot_free?(slot) ? player.play(@board.board, slot) : slot_is_taken
    else
      puts 'Please input a number between 1 and 3 honey..'
    end
  end

  def launch_game
    until @game_over
      @board.display_board
      game_on
      game_over?
    end
  end
end

my_ttt = TicTacToeGame.new('Andrea', 'Daniel')
my_ttt.launch_game
