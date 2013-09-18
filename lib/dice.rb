require 'treetop'

require File.join(File.expand_path(File.dirname(__FILE__)),'dice','dice_nodes.rb')

class Dice
  Treetop.load(File.join(File.expand_path(File.dirname(__FILE__)),'dice','dicestring'))
  @@parser = DiceStringParser.new

  def self.parse string
    @@parser.parse string
  end

  def self.rng
    @@rng ||= lambda{ |n| Random.rand(n) + 1 }
  end

  def self.roll string
    parse(string).evaluate
  end
end
