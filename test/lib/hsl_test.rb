require 'test_helper'

class HSLTest < Minitest::Test
  def test_new_validation_hue
    assert_raises(RainbowPainter::HSL::ColorError) do
      RainbowPainter::HSL.new(h: -10, s: 0, l: 0)
    end

    assert_raises(RainbowPainter::HSL::ColorError) do
      RainbowPainter::HSL.new(h: 1000.1, s: 0, l: 0)
    end
  end

  def test_new_validation_saturation
    assert_raises(RainbowPainter::HSL::ColorError) do
      RainbowPainter::HSL.new(h: 180, s: -0.5, l: 0)
    end

    assert_raises(RainbowPainter::HSL::ColorError) do
      RainbowPainter::HSL.new(h: 36, s: 10, l: 0)
    end
  end

  def test_new_validation_lightness
    assert_raises(RainbowPainter::HSL::ColorError) do
      RainbowPainter::HSL.new(h: 180, s: 0.5, l: -0.009)
    end

    assert_raises(RainbowPainter::HSL::ColorError) do
      RainbowPainter::HSL.new(h: 36, s: 1, l: 1.00001)
    end
  end

  def test_new
    hsl = RainbowPainter::HSL.new(h: 180, s: 0.5, l: 1)
    assert_equal 180, hsl.h
    assert_equal 0.5, hsl.s
    assert_equal 1.0, hsl.l
  end
end
