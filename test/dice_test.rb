require File.expand_path('../test_helper', __FILE__)

class DiceTest < MiniTest::Test
  def test_new_assigns_the_dice_string
    assert_equal '3d6', Dice.new('3d6').dice_string
  end

  def test_roll
    Random.stub :rand, 4 do
      assert_equal 15, Dice.new('3d6').roll
    end
  end

  def test_maximum
    assert_equal 20, Dice.new('3d6+2').maximum
  end

  # def test_maximum_complex
  #   assert_equal 12 - 3 - 5, Dice.new('3d4 - 3 - 5d10').maximum
  # end

  def test_minimum
    assert_equal 4, Dice.new('3d6+1').minimum
  end

  # def test_minimum_complex
  #   assert_equal 3-24, Dice.new('3d6 - 4d6').minimum
  # end
end
