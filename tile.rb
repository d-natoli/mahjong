class Tile
  include Comparable

  def self.valid_tiles
    tiles = []
    (1..9).each{ |n| tiles << "BAM#{n}" }
    (1..9).each{ |n| tiles << "CHA#{n}" }
    (1..9).each{ |n| tiles << "CIR#{n}" }
    tiles += ["DRG", "DRR", "DRW"]
    tiles += ["WIN", "WIE", "WIS", "WIW"]
    tiles
  end

  def initialize(description)
    raise ArgumentError unless self.class.valid_tiles.include?(description)

    @category, @value = description[0..-2], description[-1]
  end

  def category
    @category
  end

  def value
    @value
  end

  def description
    "#{@category}#{@value}"
  end

  def suite?
    !honour?
  end

  def honour?
    category == "DR" or category == "WI"
  end

  def same_or_next_tile?(another_tile)
    return true if self.description == another_tile.description
  
    if self.suite? and self.category == another_tile.category
      self.value.to_i == another_tile.value.to_i or
        (self.value.to_i+1) == another_tile.value.to_i
    else
      false
    end
  end

  def <=>(another_tile)
    if self.description < another_tile.description
      -1
    elsif self.description > another_tile.description
      1
    else
       0
    end
  end
end
