# frozen_string_literal: true

# rubocop:disable Style/StringLiterals
# rubocop:disable Style/Documentation
# rubocop:disable Style/For
# rubocop:disable Style/IfUnlessModifier
# rubocop:disable Metrics/AbcSize

require_relative "circles"

class Board
  include Circles

  def initialize
    @p1 = red
    @p2 = yellow
    @empty = empty
    @footer = [[1, 2, 3, 4, 5, 6, 7]]
    @board = Array.new(6) { Array.new(7, @empty) }
    @moves = 0
  end

  def print_board
    @board.reverse.each do |item|
      print item.join(" ")
      print "\n"
    end
    print @footer.join(" ")
    print "\n"
  end

  def update_board(current)
    @board.each do |column|
      next if column[current[:column]] != @empty

      column[current[:column]] = current[:coin]
      @moves += 1
      break
    end
  end

  # Method that checks if the selected column can accomodate another coin
  def space?(current)
    @board.each do |column|
      return true if column[current] == @empty
    end
    false
  end

  def win?(coin)
    return true if check_horizontal(coin)
    return true if check_vertical(coin)
    return true if check_forward_diagonal(coin)
    return true if check_backward_diagonal(coin)

    false
  end

  def draw?
    @moves >= 42
  end

  def check_horizontal(coin)
    for row in 0..5
      for column in 0..3
        next if coin != @board[row][column]
        return true if coin == @board[row][column + 1] && coin == @board[row][column + 2] && coin == @board[row][column + 3]
      end
    end
    false
  end

  def check_vertical(coin)
    for row in 0..2
      for column in 0..6
        next if coin != @board[row][column]
        return true if coin == @board[row + 1][column] && coin == @board[row + 2][column] && coin == @board[row + 3][column]
      end
    end
    false
  end

  # Forward diagonal: From lower-left to upper-right
  def check_forward_diagonal(coin)
    for row in 0..2
      for column in 0..3
        next if coin != @board[row][column]
        return true if coin == @board[row + 1][column + 1] && coin == @board[row + 2][column+2] && coin == @board[row + 3][column + 3]
      end
    end
    false
  end

  # Backward diagonal: From upper-left to lower-right
  def check_backward_diagonal(coin)
    for row in 3..5
      for column in 0..3
        next if coin != @board[row][column]
        return true if coin == @board[row - 1][column + 1] && coin == @board[row - 2][column + 2] && coin == @board[row - 3][column + 3]
      end
    end
    false
  end
end
