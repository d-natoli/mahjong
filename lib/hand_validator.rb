# frozen_string_literal: true

require 'csv'
require_relative 'hand'

# This class loads the csv file and validates the hand
class HandValidator
  def initialize(filename)
    @filename = filename
  end

  def run
    file = CSV.open(@filename)
    values = file.readline

    until values.nil?
      hand = Hand.new(values)
      puts hand.valid?
      values = file.readline
    end
  end
end
