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
      hand.should_not be_valid
    end

    it "should be invalid if there are 12 tiles but different suites" do
      tiles = []
      suites_enumerator = ["BAM", "CHA"].cycle
      12.times { tiles << "#{suites_enumerator.next}1" }
      hand = Hand.new(tiles)
      hand.should_not be_valid
    end

    it "should be invalid if there are more than 3 honour tiles" do
      tiles = []
      description_enumerator = ["BAM1", "DRG"].cycle
      12.times { tiles << description_enumerator.next }
      hand = Hand.new(tiles)
      hand.should_not be_valid
    end

    it "should be invalid if there are 2 honour tiles" do
      tiles = []
      10.times { tiles << "BAM1" }
      2.times { tiles << "DRG" }
      hand = Hand.new(tiles)
      hand.should_not be_valid
    end

    it "should be invalid if there is 1 honour tile" do
      tiles = []
      11.times { tiles << "BAM1" }
      tiles << "DRG"
      hand = Hand.new(tiles)
      hand.should_not be_valid
    end

    it "should be invalid if more than 3 suited tiles have different values" do
      tiles = []
      8.times { tiles << "BAM1" }
      4.times { tiles << "BAM3" }
      hand = Hand.new(tiles)
      hand.should_not be_valid
    end

    it "should be invalid if suited tiles are the same or in sequence" do
      tiles = []
      9.times { tiles << "BAM1" }
      tiles << "BAM2"
      tiles << "BAM3"
      tiles << "BAM5"
      hand = Hand.new(tiles)
      hand.should_not be_valid
    end

    it "should be valid if there are 12 tiles and they are the same suite and value" do
      tiles = []
      12.times { tiles << "BAM1" }
      hand = Hand.new(tiles)
      hand.should be_valid
    end

    it "should be valid if there are 12 tiles and they are the same suite despite dragons or winds" do
      tiles = []
      9.times { tiles << "BAM1" }
      3.times { tiles << "DRG" }
      hand = Hand.new(tiles)
      hand.should be_valid
    end

    it "should be valid if there are 12 tiles and they are the same suit and same or sequence values" do
      tiles = []
      9.times { tiles << "CIR5" }
      (1..3).each { |n| tiles << "CIR#{n}"}
      hand = Hand.new(tiles)
      hand.should be_valid
    end
  end
end
