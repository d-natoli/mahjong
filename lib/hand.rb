# frozen_string_literal: true

require_relative 'tile'

# This class represents a whole Mahjong hand
class Hand
  def initialize(tile_values)
    @tiles = tile_values.map { |value| Tile.new(value) }.sort
  rescue ArgumentError
    @tiles = []
  end

  attr_reader :tiles

  def valid?
    self.class.private_instance_methods.select { |m| m.to_s.start_with?('validates') }.inject(true) do |valid, v|
      valid && send(v)
    end
  end

  private

  def validates_number_of_tiles
    tiles.count == 12
  end

  def validates_hand_contains_one_suit
    tiles.map { |tile| tile.category }.compact.uniq.count == 1
  end

  def validates_hand_contains_three_or_zero_honours
    honour_tiles = tiles.map { |tile| tile if tile.honour? }.compact
    honour_tiles.count == 3 || honour_tiles.count.zero?
  end

  def validates_hand_contains_five_or_less_different_values_for_a_suite
    tiles.each_with_object(Hash.new(0)) { |tile, values| values[tile.value] += 1 if tile.suite? }.count <= 5
  end

  def validates_hand_contains_same_or_sequence_tiles
    tiles.each_slice(3) do |group|
      previous_tile = group.first

      group.each do |tile|
        return false unless previous_tile.same_or_next_tile?(tile)

        previous_tile = tile
      end
    end

    true
  end
end
