#require 'minitest/unit'
require 'minitest/autorun'
require 'treetop'
require 'dice'

class DiceParserTest < MiniTest::Unit::TestCase

  def test_integer
    assert_equal 0, Dice.roll('0')
    assert_equal 32, Dice.roll('32')
  end

  def test_float
    assert_equal 1.2301, Dice.roll('1.2301')
    assert_equal 23.123, Dice.roll('23.123')
  end

  def test_addition
    assert_equal 4, Dice.roll('1+3')
  end

  def test_subtraction
    assert_equal 3, Dice.roll('4-1')
  end

  def test_multiplication
    assert_equal 6, Dice.roll('2*3')
  end

  def test_division
    assert_equal 4, Dice.roll('8/2')
  end

  def test_parens
    assert_equal 7, Dice.roll('1+2*3')
    assert_equal 9, Dice.roll('(1+2)*3')
    assert_equal -2, Dice.roll('5-(3+4)')
  end

  def test_dice
    Random.stub :rand, 4 do
     assert_equal 10, Dice.roll('2d6')
     assert_equal 15, Dice.roll('3d12')
   end
  end

  def test_percentile
    Random.stub :rand, 40 do
      assert_equal 41, Dice.roll('1d%')
    end
  end

  def test_keep_highest
    rolls = [5,2,3]
    Random.stub :rand, lambda{|n| rolls.shift} do
      assert_equal 10, Dice.roll('3d6h2')
    end
  end

  def test_keep_lowest
    rolls = [5,2,3]
    Random.stub :rand, lambda{|n| rolls.shift} do
      assert_equal 7, Dice.roll('3d6l2')
    end
  end

  def test_multiple_dice_sets
    rolls = [4,8,1,3,2]
    Random.stub :rand, lambda{|n| rolls.shift} do
      assert_equal 23, Dice.roll('2d10+3d4')
    end
  end

  def test_assumed_one
    Random.stub :rand, 50 do
      assert_equal 51, Dice.roll('d100')
      assert_equal 53, Dice.roll('2+d100')
    end
  end

  def test_adding_an_integer_returns_a_fixnum_not_a_float
    assert_equal Fixnum, Dice.roll("1d6 + 1").class
  end

  def test_complex_case
    rolls = [4,8,1,3,2,24]
     Random.stub :rand, lambda{|n| rolls.shift} do
       assert_equal 10*(5 + 9)*(2 + (2 + 4 + 3)) /(3 - 25)+3.5, Dice.roll('10*2d10*(2+3d4)/(3-d%)+3.5')
     end
  end
end
