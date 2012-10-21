class Tile
  def initialize(description)
    @category, @value = description[0..-2], description[-1]
  end

  def category
    @category
  end

  def value
    @value
  end
end
