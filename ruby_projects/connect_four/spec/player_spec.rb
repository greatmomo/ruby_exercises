# frozen_string_literal: true

require_relative '../lib/player.rb'

describe Player do
  describe '#initialize' do
    # check if players are created with proper symbols
    subject(:player_creation) { described_class.new('☭') }

    it 'properly initializes player symbols' do
      expect(player_creation.symbol).to eq('☭')
    end
  end
end
