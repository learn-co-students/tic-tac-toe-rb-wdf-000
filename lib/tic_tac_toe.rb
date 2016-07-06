require 'pry'

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

def display_board(board) #board is an array
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  board[index] == " " && (0..8).include?(index)
end

def move(board, index, token)
  board[index] = token
  board
end

def turn(board)
  token = current_player(board)
  new_board = board
  puts "Please enter 1-9:"
  loop do
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(board, index)
      new_board = move(board, index, token)
      display_board(new_board)
      break
    else
      puts "Invalid move. Please enter 1-9:"
    end
  end
  new_board
end

def turn_count(board)
  turn_count = 0
  board.each do |slot|
    if slot == "X" || slot == "O"
      turn_count += 1
    end
  end
  turn_count
end

def current_player(board)
  turns_in = turn_count(board)
  turns_in.even? ? current_player = "X" : current_player = "O"
  current_player
end

def won?(board)
  won = false
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? {|index| position_taken?(board, index)}
      test_row = []
      win_combination.each do |index|
        test_row << board[index]
      end
      if test_row.all?{|token| token == "X"}
        won = win_combination
      elsif test_row.all?{|token| token == "O"}
        won = win_combination
      end
    end
  end
  won
end

def full?(board)
   board.none?{|element| element !="X" && element !="O"}
end

def draw?(board)
  board_full = full?(board)
  game_won = won?(board)
  if board_full && !game_won
    true
  elsif board_full && game_won
    false
  elsif !board_full
    false
  else
    false
  end
end

def over?(board)
  full?(board) || draw?(board) || won?(board) != false
end

def winner(board)
  #mandatory comment field...no I'm kidding :P
  winning_combination = won?(board)
  if winning_combination != false
    board[winning_combination.first]
  else
    nil
  end
end

def play(board)
  game_over = false
  loop do
    game_over = over?(board)
    if game_over
      if draw?(board)
        puts "Cats Game!"
      elsif won?(board) != false
        puts "Congratulations #{winner(board)}!"
      end
      break
    end
  #  puts "Current player is #{current_player(board)}"
    turn(board)
  #  binding.pry
  end
end
