require_relative "../hand"
require_relative "../tile"

describe Hand do
  it "creates Tile objects" do
    hand = Hand.new(["BAM1"])
    hand.tiles.first.kind_of?(Tile).should be_true
  end

  it "creates the correct amount of tiles" do
    tiles = ["BAM1", "BAM1", "BAM1", "CHA1"]
    hand = Hand.new(tiles)
    hand.tiles.count.should == 4
    tiles = ["BAM1", "BAM1", "BAM1", "CHA1", "CHA1", "CHA1"]
    hand = Hand.new(tiles)
    hand.tiles.count.should == 6
  end

  it "creates the correct tiles" do
    tiles = ["BAM1", "CHA2", "DRG", "WIE"]
    hand = Hand.new(tiles)
    
    hand.tiles.each_with_index do |tile, index|
      tile.category.should == tiles[index][0..-2]
      tile.value.should == tiles[index][-1]
    end
  end

  it "sorts the tiles on creation" do
    tiles = ["WIE", "BAM2", "BAM1", "CHA1", "CHA2", "DRG", "WIE"]
    hand = Hand.new(tiles)
    
    tiles.sort!

    hand.tiles.each_with_index do |tile, index|
      tile.category.should == tiles[index][0..-2]
      tile.value.should == tiles[index][-1]
    end
  end

  describe ".valid?" do
    it "should be invalid if there aren't 12 tiles" do
      hand = Hand.new(["BAM1"])
      hand.valid?.should be_false
    end

    it "should be valid if there are 12 tiles" do
      tiles = []
      12.times { tiles << "BAM1" }
      hand = Hand.new(tiles)
      hand.valid?.should be_true
    end
  end
end
