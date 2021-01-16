require 'rainbow_painter/version'

module RainbowPainter
  OUTPUT_PATH = 'tmp/'.freeze
  # A general rainbow painter error
  class Error < StandardError; end
end

require 'rainbow_painter/rgb'
require 'rainbow_painter/hsl'
require 'rainbow_painter/palette'
require 'rainbow_painter/template'
require 'rainbow_painter/export'
