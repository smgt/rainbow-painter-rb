$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.start

require 'rainbow_painter'

require 'minitest/reporters'
Minitest::Reporters.use!

require 'minitest/autorun'
