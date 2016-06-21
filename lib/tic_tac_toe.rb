
WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 4, 8],
[2, 4, 6],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def current_player(board)
  if turn_count(board).even?
   return "X"
  else
  return "O"
  end
end  

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if !(valid_move?(board, index))
    turn(board)
  else  
    move(board, index, current_player(board))
  end
end

def turn_count(board)
  turns = board.select {|position| !(position == " " || position == nil)}
  turns.length
end

def play(board)
  while !(over?(board)) 
    display_board(board)
    turn(board)
  end
  declare_finish(board)
end


def full?(board)
  empties = board.select{|position| position == " "}
  empties == []
end

def draw?(board)
  !(won?(board)) && full?(board)
end 

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def detect_indexes(board, letter)
  board.each_index.select{|index| board[index] == letter}
end

def won?(board)
  xes = detect_indexes(board, "X")
  os = detect_indexes(board, "O")
  WIN_COMBINATIONS.detect {
  |win_combo| (win_combo - xes).empty? || (win_combo - os).empty?}
end 

def winner(board)
  xes = detect_indexes(board, "X")
  os = detect_indexes(board, "O")
  if xes == won?(board)
    return "X"
  elsif os == won?(board)
    return "O"
  end
end

def declare_finish(board)
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == "O"
   puts "Congratulations O!"
  else 
    puts "Congratulations X!"
  end
end
