require 'test_helper'

class RgbTest < Minitest::Test
  def test_from_hex
    color = RainbowPainter::RGB.from_hex('#ff0000')
    color2 = RainbowPainter::RGB.from_hex('#00f')
    color3 = RainbowPainter::RGB.from_hex('0f0')
    color4 = RainbowPainter::RGB.from_hex('#a32dad')
    assert_equal [255, 0, 0], color
    assert_equal [0, 0, 255], color2
    assert_equal [0, 255, 0], color3
    assert_equal [163, 45, 173], color4
  end

  def test_parse
    assert_equal RainbowPainter::RGB.new(r: 1.0, g: 0.0, b: 0.0), RainbowPainter::RGB.parse('#FF0000')
    assert_equal RainbowPainter::RGB.new(r: 0.0, g: 0.667, b: 0.0), RainbowPainter::RGB.parse('#0A0')
    assert_equal RainbowPainter::RGB.new(r: 0.0, g: 0.667, b: 0.0), RainbowPainter::RGB.parse('rgba(0     ,170,0)')
    assert_equal RainbowPainter::RGB.new(r: 0.0, g: 0.698, b: 0.0), RainbowPainter::RGB.parse('rgba(0     ,178,0)')
    assert_equal RainbowPainter::RGB.new(r: 0.0, g: 0.0, b: 0.71), RainbowPainter::RGB.parse('rgb(0,0,71%)')
    assert_equal RainbowPainter::RGB.new(r: 1.0, g: 0.66, b: 0.71), RainbowPainter::RGB.parse('rgb(1.0,0.66,71%)')
  end

  def test_hex
    assert_equal '#ff0000', RainbowPainter::RGB.new(r: 1.0, g: 0.0, b: 0.0).hex
    assert_equal '#00aa00', RainbowPainter::RGB.parse('#0A0').hex
    assert_equal '#abc123', RainbowPainter::RGB.parse('#ABC123').hex
    assert_equal '#94469c', RainbowPainter::RGB.parse('rgb(148,70,156)').hex
    assert_equal '#40615c', RainbowPainter::RGB.parse('rgb(64,97,92)').hex
    assert_equal '#d6d9c5', RainbowPainter::RGB.parse('rgb(214, 217, 197)').hex
  end

  def test_from_rgb
    assert_equal [255, 0, 0], RainbowPainter::RGB.from_rgb('rgb(255, 0, 0)')
    assert_equal [10, 20, 30], RainbowPainter::RGB.from_rgb('rgb(10,20,30)')
    assert_equal [0, 255, 0], RainbowPainter::RGB.from_rgb('rgb(0, 255, 0)')
    assert_equal [255, 0, 0], RainbowPainter::RGB.from_rgb('rgba(100%,     0,    0)')
    assert_equal [179, 0, 0], RainbowPainter::RGB.from_rgb('rgba(70%,0,0)')
    assert_equal [0, 0, 0], RainbowPainter::RGB.from_rgb('rgb(nisse, hult, 255)')
  end

  def test_rgb_string_to_int
    assert_equal 255, RainbowPainter::RGB.rgb_string_to_int('255')
    assert_equal 128, RainbowPainter::RGB.rgb_string_to_int('50%')
    assert_equal 102, RainbowPainter::RGB.rgb_string_to_int('0.4')
    assert_equal 0, RainbowPainter::RGB.rgb_string_to_int('leif')
  end

  def test_normalize_int
    assert_equal 255, RainbowPainter::RGB.normalize_int(256)
    assert_equal 0, RainbowPainter::RGB.normalize_int(-1)
    assert_equal 140, RainbowPainter::RGB.normalize_int(140)
  end

  def test_to_fractional
    assert_equal 1, RainbowPainter::RGB.to_fractional(255)
    assert_equal 0, RainbowPainter::RGB.to_fractional(0)
    assert_equal 0.498, RainbowPainter::RGB.to_fractional(127)
  end

  def test_lighten_by
    assert_equal RainbowPainter::RGB.parse('#deb6b6').hex, RainbowPainter::RGB.parse('#662f2f').lighten_by(50).hex

    assert_equal RainbowPainter::RGB.parse('#FFF').hex, RainbowPainter::RGB.parse('#3c4f2b').lighten_by(100).hex

    assert_equal RainbowPainter::RGB.parse('#FFF').hex, RainbowPainter::RGB.parse('#3c4f2b').lighten_by(100).hex
  end

  def test_darken_by
    assert_equal RainbowPainter::RGB.parse('#8aa2b9').hex, RainbowPainter::RGB.parse('#aabbcc').darken_by(10).hex
  end

  def test_to_hsl
    rgb = RainbowPainter::RGB.parse('#ff0000')
    hsl = RainbowPainter::HSL.new(h: 0, s: 1.0, l: 0.5)
    assert_equal hsl, rgb

    rgb = RainbowPainter::RGB.parse('#498387')
    hsl = RainbowPainter::HSL.new(h: 184, s: 0.3, l: 0.41)
    assert_equal hsl, rgb

    rgb = RainbowPainter::RGB.parse('rgb(79, 135, 27)')
    hsl = RainbowPainter::HSL.new(h: 91, s: 0.67, l: 0.32)
    assert_equal hsl, rgb
  end
end
