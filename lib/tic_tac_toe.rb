# require 'pry'

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

def display_board(board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
 end
board = [" "," "," "," "," "," "," "," "," "]
display_board(board) 

def input_to_index(user_input)
   user_input.to_i - 1
end

def move(board, index, player_token)
    player_token == "X" || "O"
    board[index] = player_token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) != true
    true
  else
    return false 
  end
end

def turn(board)
  puts "Please enter 1-9:" 
  user_input = gets.strip
  index = input_to_index(user_input) 
  if valid_move?(board, index)
    # binding.pry
      move(board, index, current_player(board))
      return display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |space|
    if space != " "
      counter += 1
    end
  end
    counter
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
    # if !board.empty?
    #   return false
    # end
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
        end
      end
      return false 
end

def full?(board)
    board.each do |index|
      if index == " " 
        return false
    end
  end
end 

def draw?(board)
  if !won?(board) && full?(board)
  return true
  end
end

def over?(board)
  if won?(board) || draw?(board)  
    return true
  end
end

def winner(board)
  (win = won?(board)) != false ? board[win[0]] : nil
end

def play(board)
    if !(full?(board) || over?(board))
      turn(board) 
      play(board)
    elsif 
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cats Game!"
  end
 end 
 
#if every time you take a turn and the board isn't full || draw || won then it returns false and ask for another turn/game isn't over
#if when you take a turn and the board is full || draw || won then the game is  over it returns true



  #1st turn(board) how do we find out if this one turn in the loop = a draw?
  
  # if over?(board)
  #   return false 
  # elsif over?(board)
  #   return false 
  # else over?(board)
  #   return true 
  # end

      # turn(board)
      # if user_input = gets.strip == #expectation
      #   return 1
#     end
#   play(board)
# end