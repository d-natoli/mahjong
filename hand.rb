require_relative 'tile'

class Hand
  def initialize(tile_values)
    @tiles = []
    tile_values.each { |value| @tiles << Tile.new(value) }
    @tiles.sort!
  rescue ArgumentError
    @tiles = []
  end

  def tiles
    @tiles
  end

  def valid?
    validators = self.class.private_instance_methods.select { |m| m.to_s.start_with?("validates") }
    validators.each { |v| return false unless send(v) }
    true
  end

private
  def validates_number_of_tiles
    self.tiles.count == 12
  end

  def validates_hand_contains_one_suit
    self.tiles.map { |tile| tile.category unless tile.honour? }.compact.uniq.count == 1
  end

  def validates_hand_contains_three_or_zero_honours
    honour_tiles = self.tiles.map { |tile| tile if tile.honour? }.compact
    honour_tiles.count == 3 or honour_tiles.count == 0
  end

  def validates_hand_contains_five_or_less_different_values_for_a_suite
    values = Hash.new(0)
    tiles.each { |tile| values[tile.value] += 1 if tile.suite? }
    values.count <= 5 ? true : false
  end

  def validates_hand_contains_same_or_sequence_tiles
    self.tiles.each_slice(3) do |group|
      previous_tile = group.first
      group.each do |tile|
        return false unless previous_tile.same_or_next_tile? tile
        previous_tile = tile
      end
    end

    true
  end
end
