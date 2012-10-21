class Tile
  include Comparable

  def initialize(description)
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
