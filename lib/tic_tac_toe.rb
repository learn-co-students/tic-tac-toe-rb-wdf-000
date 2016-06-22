WIN_COMBINATIONS  = [[0,1,2] ,[3,4,5] ,[6,7,8] ,[0,3,6] ,[1,4,7] ,[2,5,8] ,[0,4,8] ,[6,4,2] ]

def display_board (board )
	puts " " +  board[0] + " | " + board[1] + " | " + board[2] + " "
	puts "-----------"
	puts " " +  board[3] + " | " + board[4] + " | " + board[5] + " "
	puts "-----------"
	puts " " +  board[6] + " | " + board[7] + " | " + board[8] + " "
end


def input_to_index ( str )
  str.to_i - 1
end

def move ( board, coord, side)
  board[coord] = side
  display_board(board)
end




# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if (index >= 0 && index <=8)
    if (position_taken?(board,index))
      return false
    else
      return true
    end
  else
    return false
  end
end

=begin
def turn(board)
  tmp = true
  index = nil
  while(tmp)
    puts "Please enter 1-9:"
    #index = gets.strip
    index = input_to_index(index)
    #until (valid_move?(board,index))

    if (valid_move?(board,index))
      tmp = false
    end
  end
  move(board,index,"X")
end
=end
=begin
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    move(board, input)
    display_board(board)
  else
    turn(board)
  end
end
=end
#=begin
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if !valid_move?(board, input)
	  turn(board)
  end
  move(board,input,current_player(board))
  display_board(board)
end
#=end


#####


def turn_count(board)
  # board.count{|token| token == "X" || token == "O"}

  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns

end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


#advance solution
# Define won?, full?, draw?, over?, and winner below
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
	won?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end


#def play(board)
#  counter = 0
#  while counter <= 8
#    counter = counter + 1
#    turn(board)
#  end
#end


def play(board)
	until (over?(board))
		if (draw?(board))
			break
		end
		turn(board)
	end

	if (won?(board))
		puts "Congratulations " + winner(board) + "!"
	elsif
		puts "Cats Game!"
	end
end



