#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/hand_validator'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: mahjong.rb [options]'

  opts.on('-i FILE', '--input FILE', 'Mahjong hands input file. Required.') do |f|
    options[:file] = f
  end

  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end.parse!

unless options[:file]
  $stderr.print "Error: missing argument. See usage (mahjong -h) for details.\n"
  exit
end

validator = HandValidator.new(options[:file])
validator.run
