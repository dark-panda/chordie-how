# -*- encoding: utf-8 -*-

require File.expand_path('../lib/chordie-how/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "chordie-how"
  s.version = ChordieHow::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["J Smith"]
  s.description = "A library for generating chord and scale charts for a variety of musical instruments."
  s.summary = s.description
  s.email = "dark.panda@gmail.com"
  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = "http://github.com/dark-panda/chordiehow"
  s.require_paths = ["lib"]

  s.add_dependency("gd2-ffij")
  s.add_dependency("builder")
end

