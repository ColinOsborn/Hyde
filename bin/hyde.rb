#!/usr/bin/env ruby

class Hyde

  attr_accessor :dir

  def initialize(filename)
    filename.chomp!
    if Dir.exist?(filename)
      puts "Error. Directory #{filename} already exists."
    else
      Dir.mkdir(filename)
    end
  end

end




if __FILE__ ==$0
  filename = gets
  h=Hyde.new(filename)

end




# args = ARGV
# puts "You ran Hyde with these arguments: #{args}"

# ##############
# Your code here
# ##############
