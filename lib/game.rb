# frozen_string_literal: true

# rubocop:disable Style/StringLiterals
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/Documentation
# rubocop:disable Metrics/MethodLength
# rubocop:disable ConditionalAssignment
# rubocop:disable Style/MultipleComparison

require_relative "circles"
require_relative "board"

class Game
  include Circles

  def initialize
    @p1 = red
    @p2 = yellow
    @board = Board.new
    @current = { player: 1, column: nil, coin: @p1 }
  end

  def play
    loop do
      introduction
      clear_screen

      # Game proper
      loop do
        @board.print_board
        status
        valid_entry
        @board.update_board(@current)
        break if @board.draw? || @board.win?(@current[:coin])

        switch_player
        clear_screen
      end

      # Announces the match result and asks for a rematch
      clear_screen
      @board.print_board
      announcement
      break unless rematch

      reset_stats
    end
  end

  def status
    puts "Game on!" if @current[:column].nil?
    print "\nPlayer #{@current[:player]}'s next move: "
    @current[:column] = gets[0].to_i - 1
  end

  def valid_entry
    loop do
      break if @board.space?(@current[:column]) && @current[:column].between?(0, 6)

      puts "Invalid input! Try again..\n"
      status
    end
  end

  def switch_player
    @current[:player] == 1 ? @current[:player] = 2 : @current[:player] = 1
    @current[:coin] == @p1 ? @current[:coin] = @p2 : @current[:coin] = @p1
    clear_screen
  end

  def rematch
    again = nil
    loop do
      puts "Do you want to play again?"
      print "Press '1' to play again or '2' to exit: "
      again = gets[0].to_i
      break if again == 1 || again == 2

      puts "\nInvalid input! Try again.."
    end
    again == 1
  end

  private

  def introduction
    puts <<~HEREDOC

      Welcome to Connect Four!
      First person to match the same colour in four consecutive cells wins.
      Player 1 will use red circles #{@p1} while Player 2 will use yellow circles #{@p2}.
      Goodluck and have fun!

    HEREDOC
    print "Enter any button to continue: "
    gets
  end

  def clear_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def announcement
    if @board.draw?
      puts "\nMatch done. It's a draw!\n"
    else
      puts "\nMatch done! Player #{@current[:player]} wins the game!\n"
    end
  end

  def reset_stats
    @board = Board.new
    @current = { player: 1, column: nil, coin: @p1 }
  end
end
