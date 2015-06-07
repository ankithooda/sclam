#!/usr/bin/env ruby

require 'yaml'

GLOBAL_SCLAM_FILE = '~/.sclam'
LOCAL_SCLAM_FILE = './.sclam'

def option_parser args
  option = args.shift
  case option
  when '-s', '--set'
    set_alias args
  when '-r', '--run'
    run_alias args
  when '-h', '--help'
    print_help
  when '-v', '--version'
    print_version
  else
    puts "Sclam : Invalid Option #{option}, -h will print help."          
  end  
end

def set_alias args
  if args.length != 2
    puts "Sclam : Invalid Argument Length, -h will print help."
  else
  end  
end

def run_alias args
  if args.length != 1
    puts "Sclam : Invalid Argument Length, -h will print help."
  else
  end
end

def print_help
  help_str = <<-EOS
  Sclam : Usage
  sclam --set ALIAS COMMAND - sets the ALIAS for the given COMMAND
  sclam --run ALIAS         - run the already set ALIAS
  EOS
  puts help_str
end

def print_version
  puts "Sclam 0.0.1"
end


def main
  option_parser ARGV
end

if __FILE__== $0
	begin
		main
	rescue Interrupt => e
		nil
	end
end
