class Board
  attr_accessor :board
  
  def initialize
    @board = Array.new(3) { Array.new(3, 0) }
  end

  def print_board
    puts

    @board.each do |row|
      row_str = row.map do |cell|
        case cell
        when 0 then " "
        when 1 then "X"
        when 2 then "O"
        else cell.to_s
        end
      end.join(" | ")

      puts " #{row_str} "
      puts "---+---+---"
    end
  end

  def check_win
    # Linhas
    if @board[0][0] != 0 &&
      @board[0][0] == @board[0][1] &&
      @board[0][1] == @board[0][2]
      return @board[0][0]
    end

    if @board[1][0] != 0 &&
      @board[1][0] == @board[1][1] &&
      @board[1][1] == @board[1][2]
      return @board[1][0]
    end

    if @board[2][0] != 0 &&
      @board[2][0] == @board[2][1] &&
      @board[2][1] == @board[2][2]
      return @board[2][0]
    end

    # Colunas
    if @board[0][0] != 0 &&
      @board[0][0] == @board[1][0] &&
      @board[1][0] == @board[2][0]
      return @board[0][0]
    end

    if @board[0][1] != 0 &&
      @board[0][1] == @board[1][1] &&
      @board[1][1] == @board[2][1]
      return @board[0][1]
    end

    if @board[0][2] != 0 &&
      @board[0][2] == @board[1][2] &&
      @board[1][2] == @board[2][2]
      return @board[0][2]
    end

    # Diagonais
    if @board[0][0] != 0 &&
      @board[0][0] == @board[1][1] &&
      @board[1][1] == @board[2][2]
      return @board[0][0]
    end

    if @board[0][2] != 0 &&
      @board[0][2] == @board[1][1] &&
      @board[1][1] == @board[2][0]
      return @board[0][2]
    end

    return true if @board.flatten.none?(0)
  false
end


end

class Human
  attr_accessor :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def play(x, y, board)
    if x < 3 and y < 3 and board[x][y] == 0
      board[x][y] = @marker
    else
      false
    end
  end
end

board = Board.new

puts "Name of Player 1"
name_1 = gets.chomp

puts "Name of Player 2"
name_2 = gets.chomp

user_1 = Human.new(name_1, 'x')
user_2 = Human.new(name_2, 'o')

i = rand(2)
player = [user_1, user_2]

while board.check_win == false
  i += 1
  puts "#{player[i % 2].name}: Write the x and y coordinator"
  x = gets.chomp.to_i
  y = gets.chomp.to_i
  try = player[i % 2].play(x, y, board.board)
  while !try
    puts "Invalid move"
    puts "#{player[i % 2].name}: Write the x and y coordinator"
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    try = player[i % 2].play(x, y, board.board)
  end
  board.print_board
end

if board.check_win == false
  puts "No one wins"
else 
  puts "#{player[i % 2].name} wins!"
end