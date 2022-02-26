# frozen_string_literal: true

require_relative '../lib/connect_four.rb'

describe ConnectFour do
  describe '#initialize' do
    # check if players are created with proper symbols
    subject(:game_creation) { described_class.new() }

    it 'properly initializes player1 symbol' do
      expect(game_creation.players[0].symbol).to eq('☭')
    end

    it 'properly initializes player2 symbol' do
      expect(game_creation.players[1].symbol).to eq('☪')
    end
  end

  describe '#play_game' do
    # Public Script Method -> No test necessary, but all methods inside need to be tested
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
        expect { game_input.player_turn }.to change { board[5].length }.by(1)
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
        7.times do
          game_input.player_turn
        end
      end
    end
  end

  describe '#toggle_player' do
    # this function should switch current_player between 1 and 2 when a valid move is made
    subject(:game_input) { described_class.new() }

    it 'toggles from 1 to 2' do
      expect { game_input.toggle_player }.to change { game_input.current_player }.from(1).to(2)
    end

    context 'toggle twice to go from 2 to 1' do
      before do
        game_input.toggle_player
      end
      
      it 'toggles from 2 to 1' do
        expect { game_input.toggle_player }.to change { game_input.current_player }.from(2).to(1)
      end
    end
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
        game_input.instance_variable_set(:@board, [['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭']])
      end

      it 'returns true' do
        expect(game_input.board_full?).to be true
      end
    end

    context 'when one column is not full' do
      before do
        # first, fill the board except for last column
        game_input.instance_variable_set(:@board, [['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],['☭','☭','☭','☭','☭','☭'],[]])
      end

      it 'returns false' do
        expect(game_input.board_full?).to be false
      end
    end
  end

  describe '#game_over?' do
    # when a move is made, check adjacent and diagonal tiles to see if there are four in a row
    subject(:game_input) { described_class.new() }

    context 'game is not over' do
      before do
        game_input.instance_variable_set(:@board, [['☭','☭'],[],[],[],[],[]])
      end

      it 'returns false' do
        expect(game_input.game_over?(0,1)).to be false
      end
    end

    context 'column victory' do
      before do
        game_input.instance_variable_set(:@board, [['☭','☭','☭','☭'],[],[],[],[],[]])
      end

      it 'returns true' do
        expect(game_input.game_over?(0,3)).to be true
      end
    end

    context 'row victory' do
      before do
        game_input.instance_variable_set(:@board, [['☭'],['☭'],['☭'],['☭'],[],[]])
      end

      it 'returns true' do
        expect(game_input.game_over?(2,0)).to be true
      end
    end

    context 'diagonal victory 1' do
      before do
        game_input.instance_variable_set(:@board, [['☭'],['@','☭'],['@','@','☭'],['@','@','@','☭'],[],[]])
      end

      it 'returns true' do
        expect(game_input.game_over?(2,2)).to be true
      end
    end

    context 'diagonal victory 2' do
      before do
        game_input.instance_variable_set(:@board, [['@','@','@','☭'],['@','@','☭'],['@','☭'],['☭'],[],[]])
      end

      it 'returns true' do
        expect(game_input.game_over?(1,2)).to be true
      end
    end
  end

  describe '#scan_vertical' do
    subject(:game_input) { described_class.new() }

    context 'connected 4 vertically' do
      before do
        game_input.instance_variable_set(:@board, [['@','☭','☭','☭','☭','@'],[],[],[],[],[]])
      end

      it 'returns true' do
        expect(game_input.scan_vertical(0,3)).to eq(4)
      end
    end
  end

  describe '#scan_horizontal' do
    subject(:game_input) { described_class.new() }

    context 'connected 4 vertically' do
      before do
        game_input.instance_variable_set(:@board, [['@'],['☭'],['☭'],['☭'],['☭'],['@']])
      end

      it 'returns true' do
        expect(game_input.scan_horizontal(3,0)).to eq(4)
      end
    end
  end

  describe '#scan_diagonal' do
    subject(:game_input) { described_class.new() }

    context 'connected 4 up_right' do
      before do
        game_input.instance_variable_set(:@board, [['☭'],['@','☭'],['@','@','☭'],['@','@','@','☭'],[],[]])
      end

      it 'returns true' do
        expect(game_input.scan_up_right(0,0)).to eq(4)
      end
    end

    context 'connected 4 up_left' do
      before do
        game_input.instance_variable_set(:@board, [['@','@','@','☭'],['@','@','☭'],['@','☭'],['☭'],[],[]])
      end

      it 'returns true' do
        expect(game_input.scan_up_left(1,2)).to eq(4)
      end
    end
  end
end
