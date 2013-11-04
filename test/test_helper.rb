# encoding: UTF-8

if RUBY_VERSION >= '1.9'
  require 'simplecov'

  SimpleCov.command_name('Unit Tests')
  SimpleCov.start do
    add_filter '/test/'
  end
end

require 'rubygems'
require 'tmpdir'
require 'yaml'
require 'minitest/autorun'

if RUBY_VERSION >= '1.9'
  require 'minitest/reporters'
end

require File.join(File.dirname(__FILE__), %w{ .. lib chordie-how })

module TestHelper
  PATH_TO_IMAGES = File.join(File.dirname(__FILE__), 'images')
  PATH_TO_FONT   = File.join(File.dirname(__FILE__), '..', 'vendor', 'fonts', 'ttf', 'DejaVuSans.ttf')

  def new_image
    GD2::Image.new(256, 256)
  end

  def load_image(file_name)
    GD2::Image.load(File.read(File.join(PATH_TO_IMAGES, file_name)))
  end
end

if RUBY_VERSION >= '1.9'
  MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)
end

