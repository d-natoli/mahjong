require_relative '../tile'

describe Tile do
  describe "#new" do
    it "should create a new tile for a bamboo tile" do
      expect{ Tile.new("BAM1") }.to_not raise_error(ArgumentError)
    end

    it "should create a new tile for a character tile" do
      expect{ Tile.new("CHA5") }.to_not raise_error(ArgumentError)
    end

    it "should create a new tile for a circle tile" do
      expect{ Tile.new("CIR9") }.to_not raise_error(ArgumentError)
    end

    it "should create a new tile for a dragon tile" do
      expect{ Tile.new("DRG") }.to_not raise_error(ArgumentError)
    end

    it "should create a new tile for a wind tile" do
      expect{ Tile.new("WIN") }.to_not raise_error(ArgumentError)
    end

    it "should throw a bad argument exception if not a valid tile category" do
      expect{ Tile.new("SIN") }.to raise_error(ArgumentError)
    end

    it "should throw a bad argument exception if not a valid tile value" do
      expect{ Tile.new("CIR10") }.to raise_error(ArgumentError)
    end
  end

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

  describe ".description" do
    it "should return the correct description for a suite" do
      tile = Tile.new("CHA3")
      tile.description.should == "CHA3"
    end

    it "should return the correct description for an honour" do
      tile = Tile.new("DRG")
      tile.description.should == "DRG"
    end
  end

  describe ".<==>" do
    it "should return 0 if the category and value are the same" do
      tile1 = Tile.new("BAM1")
      tile2 = Tile.new("BAM1")
      tile1.<=>(tile2).should be_zero
    end

    it "should return -1 if the value is less" do
      tile1 = Tile.new("BAM1")
      tile2 = Tile.new("BAM2")
      tile1.<=>(tile2).should == -1
      tile1 = Tile.new("BAM1")
      tile2 = Tile.new("CHA1")
      tile1.<=>(tile2).should == -1
    end

    it "should return 1 if the value is more" do
      tile1 = Tile.new("BAM3")
      tile2 = Tile.new("BAM2")
      tile1.<=>(tile2).should == 1
      tile1 = Tile.new("WIE")
      tile2 = Tile.new("CHA1")
      tile1.<=>(tile2).should == 1
    end
  end

  describe ".suite?" do
    it "should return false for dragons" do
      Tile.new("DRG").suite?.should be_false
    end

    it "should return false for winds" do
      Tile.new("WIE").suite?.should be_false
    end

    it "should return true for characters" do
      Tile.new("CHA1").suite?.should be_true
    end

    it "should return true for bamboos" do
      Tile.new("BAM1").suite?.should be_true
    end

    it "should return true for circles" do
      Tile.new("CIR1").suite?.should be_true
    end
  end

  describe ".honour?" do
    it "should return true for dragons" do
      Tile.new("DRG").honour?.should be_true
    end

    it "should return true for winds" do
      Tile.new("WIE").honour?.should be_true
    end

    it "should return false for characters" do
      Tile.new("CHA1").honour?.should be_false
    end

    it "should return false for bamboos" do
      Tile.new("BAM1").honour?.should be_false
    end

    it "should return false for circles" do
      Tile.new("CIR1").honour?.should be_false
    end
  end

  describe ".same_or_next_tile?" do
    let(:tile){ Tile.new("BAM2") }

    it "should return true for an equal tile" do
      tile.same_or_next_tile?(Tile.new("BAM2")).should be_true
    end

    it "should return true for next tile" do
      tile.same_or_next_tile?(Tile.new("BAM3")).should be_true
    end

    it "should return false for a tile of a different category" do
      tile.same_or_next_tile?(Tile.new("CHA2")).should be_false
    end

    it "should return false for a tile of not in sequence" do
      tile.same_or_next_tile?(Tile.new("BAM5")).should be_false
    end

    it "should return false for previous tile" do
      tile.same_or_next_tile?(Tile.new("BAM1")).should be_false
    end
  end
end
