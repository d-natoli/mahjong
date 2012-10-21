require_relative '../tile'

describe Tile do
  describe ".category" do
    it "should return the correct category for a suite" do
      tile = Tile.new("BAM1")
      tile.category.should == "BAM"
    end

    it "should return the correct category for an honour" do
      tile = Tile.new("WIE")
      tile.category.should == "WI"
    end
  end

  describe ".value" do
    it "should return the correct value for a suite" do
      tile = Tile.new("CHA3")
      tile.value.should == "3"
    end

    it "should return the correct value for an honour" do
      tile = Tile.new("DRG")
      tile.value.should == "G"
    end
  end
end
