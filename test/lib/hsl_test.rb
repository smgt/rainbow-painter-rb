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

  def test_setting_luminance
    hsl = RainbowPainter::HSL.new(h: 180, s: 0.5, l: 0.5)
    hsl.l = 0.2
    assert_equal 0.2, hsl.luminance

    hsl.luminance = 0.7
    assert_equal 0.7, hsl.l
  end

  def test_setting_saturation
    hsl = RainbowPainter::HSL.new(h: 180, s: 0.5, l: 0.5)
    hsl.s = 0.2
    assert_equal 0.2, hsl.saturation

    hsl.saturation = 0.7
    assert_equal 0.7, hsl.s
  end

  def test_setting_hue
    hsl = RainbowPainter::HSL.new(h: 180, s: 0.5, l: 0.5)
    hsl.h = 10
    assert_equal 10, hsl.hue

    hsl.hue = 190
    assert_equal 190, hsl.h

    hsl.hue = 1000
    assert_equal 360, hsl.h

    hsl.hue = -10
    assert_equal 0, hsl.h
  end

  def test_hex
    hsl = RainbowPainter::HSL.new(h: 60, s: 0.27, l: 0.42)
    assert_equal "#88884e", hsl.hex
  end
end
