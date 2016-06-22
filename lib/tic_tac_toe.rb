require "pry"
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
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    # recursive call on #turn
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each { |e| counter += 1 if e == "X" || e == "O" }
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  if board.all? { |position| position == " " }
    false
  else
    # returns the winning array with all X's
    # also returns nil if not all X's
    a =  WIN_COMBINATIONS.detect do |combination|
      combination.all? {|index| board[index] == "X"}
    end

    if (a == nil)
      return WIN_COMBINATIONS.detect do |combination|
        combination.all? {|index| board[index] == "O"}
      end
    else
      return a
    end
  end
end

def full?(board)
  board.all? { |e| e == "X" || e == "O" }
end

def draw?(board)
  # the order of the calls to #won? and #full? matter!
  # the test is expecting the call to #won? first
  !won?(board) && full?(board)
end

def over?(board)
  # no need for full? since there can't be a draw unless the board is full
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    win = won?(board)
    board[win[0]]
  end
end

def play(board)
  # while over? is false AND there isn't a draw?
  while !over?(board)
    turn(board)
    #draw?(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
