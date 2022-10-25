# frozen_string_literal: true

require_relative '../lib/tile'

describe Tile do
  describe '#new' do
    it 'creates a new tile for a bamboo tile' do
      expect { described_class.new('BAM1') }.not_to raise_error
    end

    it 'creates a new tile for a character tile' do
      expect { described_class.new('CHA5') }.not_to raise_error
    end

    it 'creates a new tile for a circle tile' do
      expect { described_class.new('CIR9') }.not_to raise_error
    end

    it 'creates a new tile for a dragon tile' do
      expect { described_class.new('DRG') }.not_to raise_error
    end

    it 'creates a new tile for a wind tile' do
      expect { described_class.new('WIN') }.not_to raise_error
    end

    it 'raises a bad argument exception if not a valid tile category' do
      expect { described_class.new('SIN') }.to raise_error(ArgumentError)
    end

    it 'raises a bad argument exception if not a valid tile value' do
      expect { described_class.new('CIR10') }.to raise_error(ArgumentError)
    end
  end

  describe '.category' do
    it 'returns the correct category for a suite' do
      tile = described_class.new('BAM1')
      expect(tile.category).to eq('BAM')
    end

    it 'returns the correct category for an honour' do
      tile = described_class.new('WIE')
      expect(tile.category).to eq('WI')
    end
  end

  describe '.value' do
    it 'returns the correct value for a suite' do
      tile = described_class.new('CHA3')
      expect(tile.value).to eq('3')
    end

    it 'returns the correct value for an honour' do
      tile = described_class.new('DRG')
      expect(tile.value).to eq('G')
    end
  end

  describe '.description' do
    it 'returns the correct description for a suite' do
      tile = described_class.new('CHA3')
      expect(tile.description).to eq('CHA3')
    end

    it 'returns the correct description for an honour' do
      tile = described_class.new('DRG')
      expect(tile.description).to eq('DRG')
    end
  end

  describe '.<==>' do
    it 'returns 0 if the category and value are the same' do
      tile1 = described_class.new('BAM1')
      tile2 = described_class.new('BAM1')
      expect(tile1.<=>(tile2)).to be_zero
    end

    it 'returns -1 if the value is less numerically' do
      tile1 = described_class.new('BAM1')
      tile2 = described_class.new('BAM2')
      expect(tile1.<=>(tile2)).to eq(-1)
    end

    it 'returns -1 if the value is less alphabetically' do
      tile1 = described_class.new('BAM1')
      tile2 = described_class.new('CHA1')
      expect(tile1.<=>(tile2)).to eq(-1)
    end

    it 'returns 1 if the value is more numerically' do
      tile1 = described_class.new('BAM3')
      tile2 = described_class.new('BAM2')
      expect(tile1.<=>(tile2)).to eq 1
    end

    it 'returns 1 if the value is more alphabetically' do
      tile1 = described_class.new('WIE')
      tile2 = described_class.new('CHA1')
      expect(tile1.<=>(tile2)).to eq 1
    end
  end

  describe '.suite?' do
    it 'returns false for dragons' do
      expect(described_class.new('DRG').suite?).to eq false
    end

    it 'returns false for winds' do
      expect(described_class.new('WIE').suite?).to eq false
    end

    it 'returns true for characters' do
      expect(described_class.new('CHA1').suite?).to eq true
    end

    it 'returns true for bamboos' do
      expect(described_class.new('BAM1').suite?).to eq true
    end

    it 'returns true for circles' do
      expect(described_class.new('CIR1').suite?).to eq true
    end
  end

  describe '.honour?' do
    it 'returns true for dragons' do
      expect(described_class.new('DRG').honour?).to eq true
    end

    it 'returns true for winds' do
      expect(described_class.new('WIE').honour?).to eq true
    end

    it 'returns false for characters' do
      expect(described_class.new('CHA1').honour?).to eq false
    end

    it 'returns false for bamboos' do
      expect(described_class.new('BAM1').honour?).to eq false
    end

    it 'returns false for circles' do
      expect(described_class.new('CIR1').honour?).to eq false
    end
  end

  describe '.same_or_next_tile?' do
    let(:tile) { described_class.new('BAM2') }

    it 'returns true for an equal tile' do
      expect(tile.same_or_next_tile?(described_class.new('BAM2'))).to eq true
    end

    it 'returns true for next tile' do
      expect(tile.same_or_next_tile?(described_class.new('BAM3'))).to eq true
    end

    it 'returns false for a tile of a different category' do
      expect(tile.same_or_next_tile?(described_class.new('CHA2'))).to eq false
    end

    it 'returns false for a tile in sequence but of a different category' do
      expect(tile.same_or_next_tile?(described_class.new('CHA3'))).to eq false
    end

    it 'returns false for a tile of not in sequence' do
      expect(tile.same_or_next_tile?(described_class.new('BAM5'))).to eq false
    end

    it 'returns false for previous tile' do
      expect(tile.same_or_next_tile?(described_class.new('BAM1'))).to eq false
    end
  end
end
