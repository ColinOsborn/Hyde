require 'fileutils'
require 'kramdown'
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
    markdown_files = []
    markdown_files += Dir.glob(filename + "/_output/*{.markdown,.md}")
    markdown_files += Dir.glob(filename + "/_output/*/*{.markdown,.md}")
    markdown_files.each do |filename|
      convert_to_html(filename)
    end
  end

  def convert_to_html(filename)
    content = @reader.read(filename)
    html_text = Kramdown::Document.new(content).to_html
    @writer.write(filename, html_text)
  end

  # def build_method(file_manager, filename)
  #   file_manager.make_basic_folders(filename)
  # end

  def make_basic_files_output
    Dir.mkdir(filename + "/css")
    Dir.mkdir(filename + "/pages")
    Dir.mkdir(filename + "/posts")
    Dir.mkdir(filename + "/layouts")
  end

  def make_output_files
    t = Time.new
    File.write(filename + "/css/main.css", "")
    File.write(filename + "/index.markdown", "")
    File.write(filename + "/pages/about.markdown", "")
    File.write(filename + "/posts/" + t.strftime("%F") + "-welcome-to-hyde.markdown", "")
  end

  end


# Upon creation, markdown should pre-poulate some basic markdown i.e.
#Blog Name
## Writen on date

# Here's some basic text to represnt where a <p> would go to show where your blog content would be.
# Another line of that, and so on and so on, and so on

# Here's an example of a list, for instance if you wanted to post a recipe or shopping list
#Shopping list:

#  * apples
#  * oranges
#  * pears

#A [link](http://example.com).

# Done

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
