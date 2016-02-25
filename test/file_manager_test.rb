gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require 'fileutils'

# require_relative '../bin/hyde'
require_relative '../lib/hyde.rb'

class FileManagerTest < MiniTest::Test

  attr_accessor :f

  def setup
    @f = FileManager.new
  end

  def test_it_creates_a_new_FileManager
    assert f1 = FileManager.new
  end

  def test_it_returns_an_error_if_it_is_given_new_for_a_directory_that_already_exists
    filename = "testfile"
    FileUtils::mkdir_p filename
    assert_equal "Error. Directory #{filename} already exists.",
                 f.create_new_site_structure(filename)
    FileUtils::remove_dir(filename, true)
  end

  def test_it_creates_the_project_at_the_given_file_path
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename)
    FileUtils::remove_dir(filename, true)
  end

  def test_it_creates_underscore_output_as_a_top_level_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename + "/_output")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_creates_source_as_a_top_level_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename + "/source")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside_source_it_creates_a_css_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename + "/source/css")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside_source_it_creates_a_layouts_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename + "/source/layouts")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside_source_it_creates_a_pages_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename + "/source/pages")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside_source_it_creates_a_posts_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert Dir.exist?(filename + "/source/posts")
    FileUtils::remove_dir(filename, true)
  end


  #File Creation Tests
  #------------------
  def test_it_creates_the_main_dot_css_File
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert File.exist?(filename + "/source/css/main.css")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_creates_the_about_dot_markdown_file
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert File.exist?(filename + "/source/pages/about.markdown")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_creates_the_index_dot_markdown_file_inside_source
    filename = "testfile"
    f.create_new_site_structure(filename)
    assert File.exist?(filename + "/source/index.markdown")
    FileUtils::remove_dir(filename, true)
  end



  def test_it_creates_the_date_dash_welcome_to_hyde_file
    filename = "testfile"
    t=Time.new
    f.create_new_site_structure(filename)
    assert File.exist?(filename + "/source/posts/#{t.strftime("%F")}-welcome-to-hyde.markdown")
    FileUtils::remove_dir(filename, true)
  end

end
