# -*- ruby -*-

require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

$:.push 'lib'

begin
	require 'jeweler'
	Jeweler::Tasks.new do |gem|
		gem.name         = "music"
		gem.version      = "0.0.1"
		gem.summary      = "A library for generating chord and scale charts for a variety of musical instruments."
		gem.description  = gem.summary
		gem.email        = "dark.panda@gmail.com"
		gem.homepage     = "http://github.com/dark-panda/music"
		gem.authors      = [ "J Smith" ]
	end
	Jeweler::GemcutterTasks.new
rescue LoadError
	puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

desc 'Test music library'
Rake::TestTask.new(:test) do |t|
	t.libs << 'lib'
	t.pattern = 'test/**/*_test.rb'
	t.verbose = false
end

