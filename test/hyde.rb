#!/usr/bin/env ruby

class Hyde

  attr_accessor :dir

  def initialize(filename)
    if Dir.exist?(filename)
      puts "Error. Directory #{filename} already exists."
    else
      Dir.mkdir(filename)
      Dir.mkdir(filename + "/_output")
      Dir.mkdir(filename + "/source")
      Dir.mkdir(filename + "/source/css")
      Dir.mkdir(filename + "/source/pages")
      Dir.mkdir(filename + "/source/posts")
      t = Time.new
      File.write(filename + "/source/css/main.css", "")
      File.write(filename + "/source/index.markdown", "")
      File.write(filename + "/source/pages/about.markdown", "")
      File.write(filename + "/source/posts/" + t.strftime("%F") + "-welcome-to-hyde.markdown", "")
    end
  end

end




if __FILE__ ==$0
  if ARGV[0] == nil
    filename = gets
    filename.chomp!
  else
    filename = ARGV[0]
  end
  h=Hyde.new(filename)

end




# args = ARGV
# puts "You ran Hyde with these arguments: #{args}"

# ##############
# Your code here
# ##############
