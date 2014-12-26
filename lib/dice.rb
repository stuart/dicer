require 'treetop'

require File.join(File.expand_path(File.dirname(__FILE__)), 'dice', 'dice_nodes.rb')

# This class encapsulates the dice parser from treetop.
class Dice
  Treetop.load(File.join(File.expand_path(File.dirname(__FILE__)), 'dice', 'dicestring'))
  @parser = DiceStringParser.new

  attr_accessor :dice_string

  def self.parse string
    @parser.parse string
  end

  def self.rng= generator
    @rng = generator
  end

  def self.rng
    @rng ||= -> (n) { Random.rand(n) + 1 }
  end

  def self.roll string
    parse(string).evaluate
  end

  def initialize dice_string
    @dice_string = dice_string
  end

  def roll
    dice.evaluate
  end

  def maximum
    dice.maximum
  end

  def minimum
    dice.minimum
  end

  private

  def dice
    self.class.parse(dice_string)
  end
end
