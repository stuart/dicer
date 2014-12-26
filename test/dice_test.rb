require 'minitest/autorun'
require 'treetop'
require 'dice'

class DiceTest < MiniTest::Test
  def test_new_assigns_the_dice_string
    assert_equal '3d6', Dice.new('3d6').dice_string
  end

  def test_roll
    Random.stub :rand, 4 do
      assert_equal 15, Dice.new('3d6').roll
    end
  end
end
