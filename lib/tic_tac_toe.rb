
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5], 
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]

]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i    #converts input string to index integer
  index = index - 1
end

def move(array, index, char)
  array[index] = char
end

def position_taken?(array, index)
  # if(array[index] == " " || array[index] == nil)
  #   false
  # else
  #   true
  # end
  !(array[index] == " " || array[index] == nil)

end

def valid_move?(array, index)
  valid = index.between?(0,8)
  if(position_taken?(array, index) == true || valid == false)
    false
  else
    true
  end
end

def turn(array)
  puts "Please enter 1-9:"
  input = gets
  input = input_to_index(input)
  player = current_player(array)
  if(valid_move?(array, input) == true)
    move(array, input, player)
  else
    turn(array)
  end
  display_board(array)
end

def turn_count(array)
  counter = 0
  array.each do |element|
    if(element == "X" || element == "O")
      counter += 1
    end
  end
  counter
end

def current_player(array)
  if(turn_count(array).odd?)
    "O"
  else
    "X"
  end
end

def won?(array)
  empty = array.all? do |element|
    element == " "
  end

  if(empty)
    return !empty

  else
    WIN_COMBINATIONS.any? do |win_combo|
      win_index1 = win_combo[0]
      win_index2 = win_combo[1]
      win_index3 = win_combo[2]

      pos1 = array[win_index1]
      pos2 = array[win_index2]
      pos3 = array[win_index3]

      if((pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O"))
        return win_combo
      else
        false
      end
    end
  end
end

def full?(array)
  !(blanks = array.include?(" "))
end

def draw?(array)
 
  !won?(array) && full?(array)
 
  # b_win = won?(array)
  # b_full = full?(array)

  # if(!b_win&& b_full)
  #   true
  # elsif(!b_win && !b_full)
  #   false
  # else
  #   false
  # end
end

def over?(array)
  (won?(array)  || draw?(array) || full?(array) )
end

def winner(array)
  if(!won?(array))
    return nil
  else
    w_array = won?(array)
    pos1 = w_array[0]

    if(array[pos1] == "X")
      "X"
    else
      "O"
    end
  end
end

def play(array)
  until(over?(array))
    turn(array)
    turn_count(array)
  end

  if(won?(array))
    puts "Congratulations #{winner(array)}!"
  else
    puts "Cats Game!"
  end
end
