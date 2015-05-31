#!/usr/bin/env ruby

require 'yaml'
require 'getoptlong'

GLOBAL_SCLAM_FILE = '~/.sclam'
LOCAL_SCLAM_FILE = './.sclam'

def main
  options = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT],
    [ '--set', '-s', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--list', '-l', GetoptLong::NO_ARGUMENT ],
    [ '--global', '-g', GetoptLong::NO_ARGUMENT],
    [ '--run', 'r', GetoptLong::REQUIRED_ARGUMENT]
  )

  options.each do |opt, args|
    case opt
    when '--help'
      puts "Somebody Help Me."
    when '--set'
      puts "Setting the alias #{args}, #{args.class}"
    when '--list'
      puts 'Listing the alias'
    when '--global'
      puts 'Calling Global'
    end
  end
end

if __FILE__== $0
	begin
		main
	rescue Interrupt => e
		nil
	end
end
