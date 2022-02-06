# frozen_string_literal: true

# rubocop:disable Style/StringLiterals

require_relative "../lib/game"
require_relative "../lib/board"

describe Game do
  subject(:game) { Game.new }
  let(:current) { game.instance_variable_get(:@current) }

  describe "#status" do
    it "Shows 'Game On!' then status turn" do
      phrase = "Game on!\n\nPlayer 1's next move: "
      expect { game.status }.to output(phrase).to_stdout
    end
    it "shows only the next move" do
      current[:column] = rand(1..7)
      phrase = "\nPlayer 1's next move: "
      expect { game.status }.to output(phrase).to_stdout
    end
  end
end

describe Board do
  subject(:board) { Board.new }
  let(:grid) { board.instance_variable_get(:@board) }

  describe "#space?" do
    let(:column) { 1 }
    let(:current) { { column: column, coin: "red" } }
    it "returns true if there is still space" do
      command = board.space?(rand(1..7))
      expect(command).to be_truthy
    end
    before do
      6.times { board.update_board(current) }
    end
    it "returns falsey if the board is full" do
      command = board.space?(column)
      expect(command).to be_falsey
    end
  end
end
