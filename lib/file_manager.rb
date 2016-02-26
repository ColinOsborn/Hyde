require 'fileutils'
require 'kramdown'
require_relative 'file_reader'
require_relative 'file_writer'

class FileManager

  def create_new_site_structure(filename)
    if Dir.exist?(filename)
      result =  "Error. Directory #{filename} already exists."
    else
      Dir.mkdir(filename)
      Dir.mkdir(filename + "/_output")
      Dir.mkdir(filename + "/source")
      make_sub_folders(filename + "/source")
      make_starting_files(filename + "/source")
      result = "File structure created"
    end
    result
  end

  def make_sub_folders(filename)
    Dir.mkdir(filename + "/css")
    Dir.mkdir(filename + "/pages")
    Dir.mkdir(filename + "/posts")
    Dir.mkdir(filename + "/layouts")
  end

  def make_starting_files(filename)
    File.write(filename + "/css/main.css", "h1 {font-size: 18px; color: firebrick} \np { font-family: Times New Roman }")
    File.write(filename + "/index.markdown", "Main Page")
    File.write(filename + "/pages/about.markdown", "About page")
    t = Time.new
    File.write(filename + "/posts/" + t.strftime("%F") + "-welcome-to-hyde.markdown", "Welcome!")
  end
end
