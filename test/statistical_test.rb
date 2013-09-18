require 'minitest/autorun'
require 'treetop'
require 'dice'

class StatisticalTest < MiniTest::Unit::TestCase


  def test_should_have_expected_maximum
    assert sample.max == 18
  end

  def test_should_have_expected_minimum
    assert sample.min == 3
  end

  def test_should_have_expected_mean
    mean = sample.inject(&:+) / 5000.0
    assert_in_delta mean, 10.5, 0.1
  end

private
  def sample
    @sample ||= Array.new(5000){Dice.roll "3d6"}
  end
end
