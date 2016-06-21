
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]]


board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, input, current_player)

  board[input] = current_player
end

def position_taken?(board, input)

  if (board[input] == "X" || board[input] == "O")
    return true
  else
    return false
  end
end

def valid_move?(board, input)

  if (!position_taken?(board, input) && input >= 0 && input < 9 )
     return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  input = input_to_index(input)
  if (valid_move?(board, input))
      current_player = current_player(board)
      move(board, input, current_player)
      display_board(board)
  else

    turn(board)

  end


end

def turn_count(board)
count = 0
 board.each do |b|
   if (b == "X" || b == "O" )
     count += 1
  end
 end
 return count
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

  if (position_1 == "X" && position_2 == "X" && position_3 == "X")
    return win_combination
  end

    if  (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end


 end

 return false
end

def full?(board)
  board.each {|b| return false if b == " "}

  return true


end


def draw?(board)
  if (!won?(board) && full?(board))

    return true
  else
    return false
 end


end

def over?(board)
if (won?(board) || full?(board) || draw?(board))
 return true
else
return false
end
end


def winner(board)
  if (won?(board))
    a = won?(board)
    return board[a[0]]
  else
    return nil
  end


end

def play(board)
 
  while(!over?(board))
    turn(board)
  end

  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
