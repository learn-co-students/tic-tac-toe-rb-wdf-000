WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #last row
  [0,3,6], #left down
  [1,4,7], #middle down
  [2,5,8], #right down
  [0,4,8], #diagonal
  [2,4,6], #diagonal
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

def move(board, index, character)
  board[index] = character
  #return modified array with updated index
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

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

# def turn_count(board)
#   count = 0
#   board.each do |character|
#     count +=1
#     if character == "X" || character == "O"
#     end
#   count
#   end
# end   #why doesn't this method work? Is it not the same as below?

def turn_count(board)
  count = 0
  board.each{|character| count+=1 if character == "X" || character == "O"}
  count
end

def current_player(board)
  #if odd number then O move [since X is 1, 3, 5, etc]
  #if even then X move
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

# def current_player(board)
#   number_turns = turn_count(board).even?
#   puts number_turns ? "X" : "O"
#   end
# end           #why doesn't this work, is it not the same as above?

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0] #grabs 0, 3, 6 etc.
    win_index_2 = win_combination[1] #grabs 1, 4, 7 etc.
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination #returns win_comb that won
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination #returns win_comb that won
    end
  end
  false
end

def full?(board)
  board.none?{|move| move == " "}
end

# def draw?(board)
#   if won?(board) == false && full?(board) == true
#     return true
#   end     #why did this method pass in last lab, but here doens't pass calling won? and full?
# end       #is this the same thing as below method?

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    return true
  end
end

def winner(board)
  if won?(board) #if this statement is true
    board[won?(board)[0]] #output this method
  else
    nil
  end
end

# def play(board)
#   #allow players to take turns
#   #check if game is over after turn
#   #if game is over - report won or draw
#   until over?(board)
#     turn(board)
#   end
#   if won?(board)
#     puts "Congratulations #{winner(board)}!"
#   elsif draw?(board)
#     puts "Cats Game!"
  #   end                   #why doesnt this method work??
# end


def play(board)
  while !over?(board) && !won?(board) #why do I have to call #won? 
    turn(board)
#    current_player(board)
#    play(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end







#
