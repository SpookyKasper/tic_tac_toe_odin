class Player
  attr_accessor :times_played
  attr_reader :name

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @times_played = 0
  end

  def valid_input?(row, column)
    (0..2).include?(row) && (0..2).include?(column)
  end

  def play(board, slot)
    if valid_input?(slot[0], slot[1])
      if board[slot[0]][slot[1]].nil?
        board[slot[0]][slot[1]] = @symbol
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

class TicTacToeGame
  def initialize(player_1, player_2)
    @player_1 = Player.new(player_1, 'X')
    @player_2 = Player.new(player_2, 'O')
    @board = Board.new(3, 3)
  end

  def who_plays?
    @player_1.times_played == @player_2.times_played ? @player_1 : @player_2
  end

  def get_user_input(player)
      choosen_slot = []
      puts "Hey #{player} which row do you wann play?"
      choosen_slot << gets.to_i - 1
      puts 'And on wich column?'
      choosen_slot << gets.to_i - 1
      choosen_slot
  end

  def launch_game
    until @board.game_over
      @board.display_board
      player = who_plays?
      player.play(@board.board, get_user_input(player.name))
      @board.game_over?
    end
  end
end

my_ttt = TicTacToeGame.new("Andrea", "Daniel")
my_ttt.launch_game
