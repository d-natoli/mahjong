# frozen_string_literal: true

require_relative '../lib/hand'
require_relative '../lib/tile'

describe Hand do
  let(:tiles) { %w[BAM1] }

  subject(:hand) { described_class.new(tiles) }

  it 'creates Tile objects' do
    expect(hand.tiles.first).to be_a(Tile)
  end

  describe "tile creation" do
    let(:tiles) { %w[WIE BAM2 BAM1 CHA1 CHA2 DRG WIE] }

    it 'creates the correct amount of tiles' do
      expect(hand.tiles.count).to eq(7)
    end

    context "when a different number of tiles" do
      let(:tiles) { %w[BAM1 BAM1 CHA1 CHA1 ] }

      it 'creates the correct amount of tiles' do
        expect(hand.tiles.count).to eq(4)
      end
    end

    it 'creates the correct tiles and they are sorted' do
      tiles.sort!

      hand.tiles.each_with_index do |tile, index|
        expect(tile.category).to eq tiles[index][0..-2]
        expect(tile.value).to eq tiles[index][-1]
      end
    end
  end

  describe '.valid?' do
    it "is invalid if there aren't 12 tiles" do
      hand = described_class.new(['BAM1'])
      expect(hand).not_to be_valid
    end

    context "when there are 12 tiles but different suites" do
      let(:tiles) do
        [].tap do |t|
          suites_enumerator = %w[BAM CHA].cycle
          12.times { t << "#{suites_enumerator.next}1" }
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there are more than 3 honour tiles' do
      let(:tiles) do
        [].tap do |t|
          description_enumerator = %w[BAM1 DRG].cycle
          12.times { t << description_enumerator.next }
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there are 2 honour tiles' do
      let(:tiles) do
        [].tap do |t|
          10.times { t << 'BAM1' }
          2.times { t << 'DRG' }
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there is 1 honour tile' do
      let(:tiles) do
        [].tap do |t|
          11.times { t << 'BAM1' }
          t << 'DRG'
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there are more than 2 honour categories' do
      let(:tiles) do
        [].tap do |t|
          9.times { t << 'BAM1' }
          2.times { t << 'DRG' }
          t << 'WIE'
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when the honour tiles are different values' do
      let(:tiles) do
        [].tap do |t|
          9.times { t << 'BAM1' }
          2.times { t << 'DRG' }
          t << 'DRR'
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when more than 3 suited tiles have different values' do
      let(:tiles) do
        [].tap do |t|
          8.times { t << 'BAM1' }
          4.times { t << 'BAM3' }
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there a two sets of sequences' do
      let(:tiles) do
        [].tap do |t|
          6.times { t << 'BAM1' }
          (1..3).each { |n| t << "BAM#{n}" }
          (5..8).each { |n| t << "BAM#{n}" }
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there a two sets of sequences and there is a set of honours' do
      let(:tiles) do
        [].tap do |t|
          3.times { t << 'DRG' }
          3.times { t << 'BAM1' }
          (1..3).each { |n| t << "BAM#{n}" }
          (5..8).each { |n| t << "BAM#{n}" }
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when suited tiles are not the same or in sequence' do
      let(:tiles) do
        [].tap do |t|
          9.times { t << 'BAM1' }
          t.concat(%w[BAM2 BAM3 BAM5])
        end
      end

      it 'is invalid' do
        expect(hand).not_to be_valid
      end
    end

    context 'when there are 12 tiles and they are the same suite and value' do
      let(:tiles) { Array.new(12) { 'BAM1' } }

      it 'is valid' do
        expect(hand).to be_valid
      end
    end

    context 'when there are 12 tiles and they are the same suit and same or sequence values' do
      let(:tiles) do
        [].tap do |t|
          3.times { |n| t.concat(['CIR5', 'CIR9', 'CIR2', "CIR#{n + 1}"]) }
        end
      end

      it 'is valid' do
        expect(hand).to be_valid
      end
    end
  end
end
