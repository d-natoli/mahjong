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
    self.tiles.map { |tile| tile.category unless tile.honour? }.compact.uniq.count == 1
  end

  def validates_hand_contains_three_or_zero_honours
    honours = self.tiles.map { |tile| tile if tile.honour? }.compact
    honours.count == 3 or honours.count == 0
  end

  def validates_hand_contains_three_or_less_values_for_a_suite
    suite_tiles = self.tiles.select{ |tile| tile.suite? }

    values = Hash.new(0)

    suite_tiles.each do |tile|
      values[tile.value] += 1
      return true if values[tile.value] == suite_tiles.count - 3
    end

    false
  end
end
