require 'csv'
require_relative 'hand'

class HandValidator
  def initialize(filename)
    @filename = filename
  end

  def run
    file = CSV.open(@filename)
    values = file.readline

    while(values != nil) do
      hand = Hand.new(values)
      puts hand.valid?
      values = file.readline
    end
  end
end
