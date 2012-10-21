class Hand
  def initialize(tiles)
    @tiles = []

    tiles.each do |tile|
      @tiles << Tile.new(tile)
    end
    
    @tiles.sort!
  end

  def tiles
    @tiles
  end
end
