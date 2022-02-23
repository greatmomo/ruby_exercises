# frozen_string_literal: true

require_relative '../lib/connect_four.rb'

describe ConnectFour do
  describe '#initialize' do
    # No test necessary if only creating instance variables.
  end

  describe '#play_game' do
    # Public Script Method -> No test necessary, but all methods inside need to be tested
  end

  describe '#player_input' do
    # Located inside #play_game (Public Script Method)
    # Looping Script Method -> Test the behavior of the method

    # Selection is valid if the column exists and isn't full (7 columns, 6 rows)
    subject(:game_input) { described_class.new() }

    context 'when the input is valid' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        min = game_input.instance_variable_get(:@minimum)
        max = game_input.instance_variable_get(:@maximum)
        error_message = "Input error! Please enter a number between #{min} or #{max}."
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input(min, max)
      end
    end

    context 'when the user enters a column off the board, then a valid column' do
      before do
        invalid_input = '11'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'completes loop and displays error message once' do
        min = game_input.instance_variable_get(:@minimum)
        max = game_input.instance_variable_get(:@maximum)
        error_message = "Input error! Please enter a number between #{min} or #{max}."
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input(min, max)
      end
    end
  end

  describe '#player_turn' do
    # Loops until valid input is entered
    subject(:game_input) { described_class.new() }

    context 'when user input is valid' do
      before do
        valid_input = 6
        allow(game_input).to receive(:player_input).and_return(valid_input)
      end

      it 'enters a token in the selected column' do
        board = game_input.instance_variable_get(:@board)
        expect(game_input).to change { board[6].length }.by(1)
        game_input.player_turn(1)
      end
    end

    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        letter = 'd'
        valid_input = 6
        allow(game_input).to receive(:player_input).and_return(letter, valid_input)
      end

      it 'completes loop and displays error message once' do
        board = game_input.instance_variable_get(:@board)
        expect(game_input).to change { board[6].length }.by(1)
        game_input.player_turn(1)
      end
    end

    context 'when the user enters a column that is full, then a valid column' do
      before do
        valid_input = 6
        allow(game_input).to receive(:player_input).and_return(valid_input, valid_input, valid_input, valid_input, valid_input, valid_input, valid_input)
      end

      it 'completes loop 6 times, then an error when the column is full' do
        error_message = "Input error! The selected column is full!"
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_turn(1)
      end
    end
  end

  describe '#verify_input' do
    # Located inside #play_game (Looping Script Method)
    # Query Method -> Test the return value
    subject(:game_input) { described_class.new() }

    context 'when given a valid input as argument' do
      it 'returns valid input' do
        valid_input = '3'
        min = game_input.instance_variable_get(:@minimum)
        max = game_input.instance_variable_get(:@maximum)
        expect(game_input.verify_input(min, max, valid_input.to_i)).to eq(3)
      end
    end

    context 'when given invalid input as argument' do
      it 'returns nil' do
        invalid_input = '11'
        min = game_input.instance_variable_get(:@minimum)
        max = game_input.instance_variable_get(:@maximum)
        expect(game_input.verify_input(min, max, invalid_input.to_i)).to be_nil
      end
    end
  end

  describe '#board_full?' do
    # Query Method -> Test the return value

    subject(:game_input) { described_class.new() }

    context 'when all columns are full' do
      before do
        # first, fill the board
        (0..6).each do |valid_input|
          allow(game_input).to receive(:player_input).and_return(valid_input, valid_input, valid_input, valid_input, valid_input, valid_input)
        end
        allow(game_input).to receive(:player_input).and_return(3)
      end

      it 'returns true' do
        expect(game_input.board_full?).to eql(true)
      end
    end

    context 'when one column is not full' do
      before do
        # first, fill the board except for last column
        (0...6).each do |valid_input|
          allow(game_input).to receive(:player_input).and_return(valid_input, valid_input, valid_input, valid_input, valid_input, valid_input)
        end
      end

      it 'returns false' do
        expect(game_input.board_full?).to eql(false)
      end
    end
  end
end
