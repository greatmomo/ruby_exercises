# frozen_string_literal: true

require_relative '../lib/tic_tac_toe.rb'

describe Player do
  context 'initialize a proper Player' do
    subject(:test_player) { described_class.new('Jim', '@') }

    it 'sets name' do
      expect(test_player.name).to eql('Jim')
    end

    it 'sets symbol' do
      expect(test_player.symbol).to eql('@')
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
  describe '#intro' do
  end

  describe '#game_loop' do
  end

  describe '#play_prompt' do
  end

  describe '#input_valid?' do
  end

  describe '#game_over?' do
  end
end

  # subject(:phrase) { described_class.new('Lipps, Asvph!', translator) }
  # let(:translator) { instance_double(CaesarTranslator) }

    # before do
    #   allow(translator).to receive(:translate)
    # end

    # it 'sends translate 26 times' do
    #   expect(translator).to receive(:translate).exactly(26).times
    #   phrase.create_decrypted_messages
    # end