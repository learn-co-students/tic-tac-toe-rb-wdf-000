# require 'pry'
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
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

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  until over?(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      token = current_player(board)
      move(board, index, token)
      display_board(board)
    else
      turn(board)
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end


def current_player(board)
  num = turn_count(board)
  token = ""
  if num % 2 == 0
    return token = "X"
  else
    return token = "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
       return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end

    if board.all? do |string|
      string == "" || string == " "
      return false
    end
  end
end

def full?(board)
  board.any? do |space|
    if space == "" || space == " "
       false
    end
  end
  board.all? do |space|
    if space == "X" || space == "O"
       true
    end
  end
end

def draw?(board)
  if !won?(board) && full?(board)
     true
  else
     false
  end
end

def over?(board)

  if draw?(board) || won?(board) || full?(board)
     true
  else
     false
  end
end

def winner(board)
  if won?(board)
    combination = won?(board)
    position = combination[1]
    board[position]
  else
     nil
  end

end

# Define your play method below

def play(board)
  turn(board)

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

# binding.pry
