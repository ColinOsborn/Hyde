require 'kramdown'
require 'erb'
require 'fileutils'
require_relative 'file_reader'
require_relative 'file_writer'
require_relative 'file_manager'

class SiteBuilder

  attr_accessor :file_manager

  def initialize
    @file_manager = FileManager.new
    @reader = FileReader.new
    @writer = FileWriter.new
  end

  def build(filename)
    FileUtils.copy_entry(filename + "/source/", filename + "/_output/")
    FileUtils.copy_entry("./lib/default.html.erb", filename + "/_output/layouts/default.html.erb" )
    markdown_files = []
    markdown_files += Dir.glob(filename + "/_output/*{.markdown,.md}")
    markdown_files += Dir.glob(filename + "/_output/*/*{.markdown,.md}")
    # Add a step here to generate the default layout file and populate it with canned content
    # (should go in source/layouts/default.html.erb)
    markdown_files.each do |filename|
      content = @reader.read(filename)
      content = convert_to_html(content)
      @writer.write(filename.gsub(".markdown", ".html"), content)
      puts filename
      File.delete(filename)
    end
  end

  def convert_to_html(content)
    html_text = Kramdown::Document.new(content).to_html
  end

end


if __FILE__ ==$0
  if ARGV[1] == nil
    puts "No filename given"
  else
    filename = ARGV[1]
    case ARGV[0]
    when nil
      puts "No command given"
    when "new"
      # filename = gets
      # filename.chomp!
      f=FileManager.new
      f.create_new_site_structure(filename)
    when "build"
      b = SiteBuilder.new
      b.build(filename)
    end
  end
end
