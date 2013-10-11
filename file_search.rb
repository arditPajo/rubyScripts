#!/usr/bin/env ruby
require 'term/ansicolor'
include Term::ANSIColor

class Search
	attr_reader	:filename
	def initialize(filename)
		@filename = filename
	end

	def process_file(valueToFind)
		puts "---- Opening: #{@filename}"
		afile = File.open(@filename, 'r')
		lineProcessed = 1
		searchResults = 0
		afile = File.open(@filename, 'r')
		afile.each do |line|
		 	if line =~ /#{valueToFind}/
		 		print green("#{lineProcessed}") + ":#{$`}" + red("#{$&}") + "#{$'}" 
		 		searchResults += 1
		 	end
		 	lineProcessed += 1
		end
		if searchResults == 0
			puts yellow("\t<< No Search Results >>")
		else
			puts yellow("\t#{searchResults} search result(s) found on: #{@filename}")
		end
		afile.close
	end

	def line_count
		lineProcessed = 1;
		afile = File.open(@filename, 'r')
		afile.each {lineProcessed += 1}
		puts "File: "+ red("#{@filename}") + ", Lines: " + green("#{lineProcessed}")
		afile.close
	end
end

inputNumber = ARGV.length
if inputNumber >= 2
	if ARGV[0] == '-f'
		ARGV.each do |filename|
			searching = Search.new(filename)
			searching.process_file(ARGV[inputNumber - 1]) if File.file?(filename)
		end
	elsif ARGV[0] == '-lc'
		ARGV.each do |filename|
			searching = Search.new(filename)
			searching.line_count if File.file?(filename)
		end
	end
elsif ARGV[0] == "-h" || ARGV[0] == "--help"
	puts "______ FILE SEARCH HELP____________"
	puts "Find: \./file_search.rb -f{the files} {the thing tou want to search}"
	puts "LineCount: \./file_search.rb -lc {the files}"
	puts "******************************"
else
	puts "Too few arguments ... try ./file_search --help or ./file_search -h"
end