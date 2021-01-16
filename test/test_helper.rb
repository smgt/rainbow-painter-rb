$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rainbow_painter"

require 'minitest/reporters'
Minitest::Reporters.use!

require "minitest/autorun"
