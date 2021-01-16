require 'test_helper'

class TemplateTest < Minitest::Test
  def test_template_load_colors_dracula
    palette = RainbowPainter::Palette.load_path('palettes/dracula.json')
    template = RainbowPainter::Template.new(palette: palette, template_path: 'templates/colors')
    assert_equal "#282a36\n#f8f8f2\n#21222c\n#ff5555\n#50fa7b\n#f1fa8c\n#bd93f9\n#ff79c6\n#8be9fd\n#f8f8f2\n#6272a4\n#ff6e6e\n#69ff94\n#ffffa5\n#d6acff\n#ff92df\n#a4ffff\n#ffffff\n", template.render
  end

  def test_template_load_colors_space_vim
    palette = RainbowPainter::Palette.load_path('palettes/space-vim-dark.json')
    template = RainbowPainter::Template.new(palette: palette, template_path: 'templates/colors')
    assert_equal "#262626\n#a3a3a3\n#262626\n#cb4674\n#74d55c\n#a18417\n#627ad2\n#9f46b3\n#af87d7\n#a3a3a3\n#555f69\n#fc4474\n#96e931\n#e89e0f\n#4083cd\n#d358d5\n#22abbb\n#dfdfdf\n", template.render
  end

  def test_template_file_not_found
    assert_raises(RainbowPainter::Template::FileNotFound) {
      RainbowPainter::Template.new(palette: RainbowPainter::Palette.new({}), template_path: "foobar")
    }
  end
end
