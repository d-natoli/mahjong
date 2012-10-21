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
end
