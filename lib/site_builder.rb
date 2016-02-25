require 'fileutils'
require 'kramdown'
require 'erb'
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
    # Add a step here to generate the default layout file and populate it with canned content
    # (should go in source/layouts/default.html.erb)
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
    File.write(filename + "/pages/about.markdown", "# About Page\n\nhere's the about page")
    File.write(filename + "/posts/" + t.strftime("%F") + "-welcome-to-hyde.markdown", "")
  end

end

class BlogPop
  include ERB::Util

  def initialize(post_name, template, date=Time.now)
    # 1 - read the layout file from source/layouts/default.html.erb into our template string
    File.read("#{file_path}source/layouts/default.html.erb")
    html_body = convert_to_html()
    html_file_path = #markdown file located in correct directory
    File.write()
    # 2 - render the current item (by translating its markdown to HTML) --> make this some local variable in your method
    def render("source/layouts/default.html.erb")
      simple_template = "Today is <%= weekday %>."
      ERB.new().result(binding)
    # 3 - use ERB to inject that rendered html into the layout -- pass it the binding of the method you're rendering _from_
    def render_html_with_template(file_path, html_body)
      erb_template = File.read("#{file_path}/source/layouts/default.html.erb")
      ERB.new(erb_template).result(binding)
    end        @template
    #     so that it can access the stuff it needs to render the ERB
    @post_name = post_name
    @template = template
    @date
  end
  # def build_html_files(file_path)
  #     Dir.glob("#{file_path}/**/*.md") do |md_file_path|
  #       html_body = convert_html_from_markdown(md_file_path)
  #       contents = render_html_with_template(file_path, html_body)
  #       html_file_path = md_file_path.gsub(/.md/, ".html").sub(/source/, "output")
  #       File.write(html_file_path, contents)
  #     end
  # def save(file)
  #   File.open(file, "w+") do |f|
  #     f.write(render)
  #   end
  end

end

puts output = renderer.result(list.get_binding)


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
