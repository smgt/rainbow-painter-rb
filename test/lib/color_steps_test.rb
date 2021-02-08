require 'test_helper'

module RainbowPainter
  class ColorStepsTest < Minitest::Test
    def test_steps_colors
      cs = ColorSteps.new(RGB.new(r: 0, g: 0, b: 0), RGB.new(r: 1.0, g: 1.0, b: 1.0))
      steps = cs.steps(5)
      steps.each_with_index do |color, i|
        assert_equal 1/6.0*(i+1), color.red
      end
    end

    def test_delta
      black = RGB.new(r: 0, g: 0, b: 0)
      white = RGB.new(r: 1, g: 1, b: 1)
      cs = ColorSteps.new(black, white)
      assert_equal 1/6.0, cs.delta(0, 1, 5)
    end

    def test_steps_size
      cs = ColorSteps.new(RGB.new(r: 0, g: 0, b: 0), RGB.new(r: 1.0, g: 1.0, b: 1.0))
      assert_equal 5, cs.steps(5).size
    end
  end
end
