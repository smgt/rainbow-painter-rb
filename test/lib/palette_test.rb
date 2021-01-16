require 'test_helper'

class PaletteTest < Minitest::Test
  def test_load_palette
    file = '{"colors":{ "terminal": {"color1": "#FF0000", "color2": "rgb(255,0,0)", "color3":"#b39780"}}}'
    palette = RainbowPainter::Palette.load_palette_json(file)
    assert_equal 1.0, palette.color1.r
    assert_equal 1.0, palette.color2.r
    assert_equal 0.502, palette.color3.b
  end

  def test_load_palette_file_dracula
    palette = RainbowPainter::Palette.load_path('palettes/dracula.json')
    assert_equal 'Dracula', palette.name
    assert_equal '#282a36', palette.background.hex
    assert_equal '#f8f8f2', palette.foreground.hex
    assert_equal '#21222c', palette.color0.hex
    assert_equal '#ff5555', palette.color1.hex
    assert_equal '#50fa7b', palette.color2.hex
    assert_equal '#f1fa8c', palette.color3.hex
    assert_equal '#bd93f9', palette.color4.hex
    assert_equal '#ff79c6', palette.color5.hex
    assert_equal '#8be9fd', palette.color6.hex
    assert_equal '#f8f8f2', palette.color7.hex
    assert_equal '#6272a4', palette.color8.hex
    assert_equal '#ff6e6e', palette.color9.hex
    assert_equal '#69ff94', palette.color10.hex
    assert_equal '#ffffa5', palette.color11.hex
    assert_equal '#d6acff', palette.color12.hex
    assert_equal '#ff92df', palette.color13.hex
    assert_equal '#a4ffff', palette.color14.hex
    assert_equal '#ffffff', palette.color15.hex
  end
end
