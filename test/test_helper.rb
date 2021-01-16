$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'rainbow_painter'

require 'simplecov'
SimpleCov.start

require 'minitest/reporters'
Minitest::Reporters.use!

require 'minitest/autorun'
