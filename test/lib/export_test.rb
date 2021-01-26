require 'test_helper'

# Tests for export.rb
class ExportTest < Minitest::Test
  RainbowPainter::OUTPUT_PATH = './'
  def test_user_template_path
    exp = RainbowPainter::Export.new(palette: {})
    Dir.stub :glob, ['colors.sh'] do
      assert_includes exp.user_template_paths, "colors.sh"
    end
  end

  def test_template_path
    exp = RainbowPainter::Export.new(palette: {})
    Dir.stub :glob, ['/asd/colors.sh'] do
      assert_includes exp.user_template_paths, "/asd/colors.sh"
    end
  end
end
