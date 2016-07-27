# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # First column
  [1,4,7],  # Second column
  [2,5,8],  # Third column
  [0,4,8],  # Diagonal left-right
  [2,4,6]  #Diagonal right-left
  # ETC, an array for each win combination
]
# Display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# Input to index
def input_to_index(user_input)
  user_input.to_i - 1
end
# Move
def move(board, index, current_player)
  board[index] = current_player
end

# Position taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Valid move
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  count = 0
  num = 0
  while num < 9 do
    if board[num] != " "
      count += 1
    end
    num += 1
  end
    count
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    "X"
  else
    "O"
  end
end

# Won method
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
  # binding.pry
    position_1 = board[win_combination[0]] # load the value of the board at win_index_1
    position_2 = board[win_combination[1]] # load the value of the board at win_index_2
    position_3 = board[win_combination[2]] # load the value of the board at win_index_3

    if position_1 == " " || position_2 == " " || position_3 == " "
      false
    elsif position_1 == position_2 && position_2 == position_3 && position_1 != " "
     return win_combination
    end
  end
  false
end

# Full method
def full?(board)
  board.all? do |position|
    position != " "
  end
end

# Draw method
def draw?(board)
  !won?(board) && full?(board) 
      
end

# Over method
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

# won?(board) ? board[won?(board)[0]] : nil
def winner(board)
  if won?(board)
    position = won?(board)
    if board[position[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

# Play method
def play(board)
 until over?(board) do
   turn(board)
 end
 if won?(board)
   puts "Congratulations #{winner(board)}!"  
 elsif draw?(board)
   puts "Cats Game!"

 end

end


