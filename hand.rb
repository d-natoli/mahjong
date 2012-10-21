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

  def validates_hand_contains_one_suit
    self.tiles.map { |t| t.category unless t.honour? }.compact.uniq.count == 1
  end

  def validates_hand_contains_three_or_zero_honours
    honours = self.tiles.map { |t| t if t.honour? }.compact
    honours.count == 3 or honours.count == 0
  end
end
