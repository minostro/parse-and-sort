#!/usr/bin/env ruby
require 'optparse'
require_relative 'command_line_app'
options = {filepath: nil, delimiter: nil}

parser = OptionParser.new do|opts|
  opts.banner = "Usage: console.rb [options]"
  opts.on('-f', '--filepath filepath', 'Filepath') do |filepath|
    options[:filepath] = filepath;
  end

  opts.on('-d', '--delimiter delimiter', 'Delimiter') do |delimiter|
    options[:delimiter] = delimiter;
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end

parser.parse!
CommandLineApp.main(options[:filepath], options[:delimiter])
