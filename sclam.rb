#!/usr/bin/env ruby

require 'json'

SCLAM_FILE = '~/.sclam'

def option_parser args
  option = args.shift
  case option
  when '-s', '--set'
    set_alias args
  when '-r', '--run'
    run_alias args
  when '-l', '--list'
    list_alias
  when '-d', '--del'
    del_alias args
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
    # read the already written aliases from the json file
    alias_hash = read_json SCLAM_FILE

    # just setting the ALIAS for the COMMAND, it will overwrite previous set alias
    alias_hash[args[0]] = args[1]

    # write back the json
    write_json SCLAM_FILE, alias_hash
  end
end

def run_alias args
  if args.length != 1
    puts "Sclam : Invalid Argument Length, -h will print help."
  else
    # read the alias json from sclam file
    alias_hash = read_json SCLAM_FILE

    if alias_hash[args[0]].nil?
      puts "No alias found : #{args[0]}, Use -s to set one first. -h will print help"
    else
      # replace the sclam process by the command to be executed
      exec alias_hash[args[0]]
    end
  end
end

def list_alias
  # read the alias json from sclam file
  alias_hash = read_json SCLAM_FILE

  # print all the alias stored in the json
  alias_hash.each do |k, v|
    puts "#{k}       -> #{v}"
  end
end

def del_alias args
  if args.length != 1
    puts "Sclam : Invalid Argument Length, -h will print help."
  else
    # read the alias json from sclam file
    alias_hash = read_json SCLAM_FILE

    # delete the given alias from json
    alias_hash.delete args[0]

    # write back the json
    write_json SCLAM_FILE, alias_hash
  end
end

def print_help
  help_str = <<-EOS
  Sclam : Usage
  sclam -s, --set ALIAS COMMAND - sets the ALIAS for the given COMMAND
  sclam -r, --run ALIAS         - run the already set ALIAS
  sclam -l, --list              - list all alias set till now
  sclam -d, --del ALIAS         - delete ALIAS
  EOS
  puts help_str
end

def print_version
  puts "Sclam 0.0.1"
end

def write_json file_name, hash
  File.open(file_name,"w") do |f|
    f.write(hash.to_json)
  end
end

def read_json file_name
  begin
    JSON.parse( IO.read(file_name) )
  rescue Errno::ENOENT
    # return empty hash if .sclam has not been created
    {}
  end
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
