require 'pry'

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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  num.to_i - 1
end

def move(b,i,c)
  b[i]=c
  display_board(b)
end

def position_taken?(board, index)
  if board.empty? || board[index] == "" || board[index] == " " || board[index]== nil
    false
  elsif board[index]=="X" || board[index] =="O"
    true
  end
end

def valid_move?(board, index)
  result = false
  if (0..8).include?(index) && board[index] !="X" && board[index] !="0"
    result = true
  end
  result
end

def turn(board)

  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  !valid_move?(board,index) ? turn(board) : move(board,index,current_player(board))

end

def turn_count(board)
  c=0
  board.each { |char| c+=1 if char=="X" || char=="O" }
  c
end

def current_player(board)
  c=0
  board.each { |char| c+=1 if char=="X" || char=="O" }
  c%2==0? "X" : "O"
end

def won?(board)
  result = false
  if !board.all? { |space| space == " "  }
    WIN_COMBINATIONS.each do |win|
      if board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] && board[win[0]] != " "
        result = win
      end
    end
  end
 result
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  draw?(board) || won?(board) ? true : false
end

def winner(board)
  (winner= won?(board)) != false ? board[winner[0]] : nil
end

def play(board)
  if !over?(board)
    turn(board)
    play(board)
  elsif draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
