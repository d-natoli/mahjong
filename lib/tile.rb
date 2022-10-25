# frozen_string_literal: true

# This class represents a tile
class Tile
  include Comparable

  VALID_TILES = %w[DRG DRR DRW WIN WIE WIS WIW] + (1..9).each_with_object([]) do |n, t|
    t << "BAM#{n}"
    t << "CHA#{n}"
    t << "CIR#{n}"
  end.sort.freeze

  def initialize(description)
    raise ArgumentError unless VALID_TILES.include?(description)

    @category = description[0..-2]
    @value = description[-1]
  end

  attr_reader :category, :value

  def description
    "#{@category}#{@value}"
  end

  def suite?
    !honour?
  end

  def honour?
    %w[DR WI].include?(category)
  end

  def same_or_next_tile?(another_tile)
    return true if self == another_tile

    suite? && next_tile == another_tile
  end

  def <=>(other)
    if description < other.description
      -1
    elsif description > other.description
      1
    else
      0
    end
  end

  private

  def next_tile
    self.class.new(VALID_TILES[VALID_TILES.index(description) + 1])
  end
end
