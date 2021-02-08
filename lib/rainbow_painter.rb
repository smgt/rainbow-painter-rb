require 'rainbow_painter/version'
require 'fileutils'

module RainbowPainter
  OUTPUT_PATH = File.expand_path('~/.config/rainbow-painter').freeze
  CACHE_PATH = File.expand_path('~/.cache/rainbow-painter').freeze
  # A general rainbow painter error
  class Error < StandardError; end
end

FileUtils.mkdir_p RainbowPainter::OUTPUT_PATH unless File.exist?(RainbowPainter::OUTPUT_PATH)

FileUtils.mkdir_p RainbowPainter::CACHE_PATH unless File.exist?(RainbowPainter::CACHE_PATH)

require 'rainbow_painter/rgb'
require 'rainbow_painter/hsl'
require 'rainbow_painter/palette'
require 'rainbow_painter/template'
require 'rainbow_painter/export'
require 'rainbow_painter/color_steps'
