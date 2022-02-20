# frozen_string_literal: true

require_relative '../lib/tic_tac_toe.rb'

describe Player do
  subject(:test_player) { described_class.new('Jim', '@') }

  describe '#initialize' do
    context 'when solution is initialized' do
      it 'name is properly set' do
        expect(test_player.name).to eql('Jim')
      end

      it 'symbol is properly set' do
        expect(test_player.symbol).to eql('@')
      end
    end
  end
end

describe Board do
  subject(:test_board) { described_class.new }
  symbol = '@'
  index = 2

  describe '#set_board' do
    it 'sets the 3rd index to @' do
      expect { test_board.set_board(symbol, index) }.to change { test_board.board[index] }.from(3).to('@')
    end
  end
end

describe Game do
  subject(:test_game) { described_class.new }

  describe '#intro' do
    context 'gets input 4 times and creates two players' do
      it 'creates player 1' do
        @@player1 = Player.new('Momo', '@')
        expect(@@player1.name).to eql('Momo')
        expect(@@player1.symbol).to eql('@')
      end

      it 'creates player 2' do
        @@player2 = Player.new('Ori', '&')
        expect(@@player2.name).to eql('Ori')
        expect(@@player2.symbol).to eql('&')
      end
    end
  end

  describe '#game_loop' do
    context 'when the game is over, print the winner' do
      before do
        @@player1 = Player.new('Momo', '@')
        @@player2 = Player.new('Ori', '&')
        @@victory_state = true
      end

      it 'no victor means a tie' do
        @@victor = 0
        tie = "It's a tie!"
        expect(test_game).to receive(:puts).with(tie).once
        test_game.game_loop
      end

      it 'player1 victory' do
        @@victor = 1
        message = "#{@@player1.name} wins!"
        expect(test_game).to receive(:puts).with(message).once
        test_game.game_loop
      end

      it 'player2 victory' do
        @@victor = 2
        message = "#{@@player2.name} wins!"
        expect(test_game).to receive(:puts).with(message).once
        test_game.game_loop
      end
    end
  end

  describe '#play_prompt' do
    # just a simple gets, probably doesn't need a test
  end

  describe '#input_valid?' do
    context 'returns false for invalid input and true for valid input' do
      before do
        invalid_input2 = 'a'
        Board.set_board('@', 2)
        invalid_input3 = 3
        valid_input = 5
      end

      it 'when input is too long' do
        value = 12
        expect(test_game.input_valid?(value)).to eql(false)
      end
    end
  end

  describe '#game_over?' do
  end
end
