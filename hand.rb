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

  def valid?
    validators = self.class.private_instance_methods.select { |m| m.to_s.start_with?("validates") }
    
    validators.each do |validator|
      return false unless send(validator)
    end

    true
  end

private
  def validates_number_of_tiles
    self.tiles.count == 12
  end
end
