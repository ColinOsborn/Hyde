gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'


require_relative '../lib/site_builder'

class BuildTest < MiniTest::Test



  attr_accessor :f
  attr_accessor :b

  def setup
    @b = SiteBuilder.new
    @f = FileManager.new
  end

  def test_inside__output_it_creates_a_css_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/css")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside_source_it_creates_a_layouts_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/layouts")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside__output_it_creates_a_pages_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/pages")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside__output_it_creates_a_posts_folder
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/posts")
    FileUtils::remove_dir(filename, true)
  end


  #File Creation Tests
  #------------------
  def test_it_copies_the_main_dot_css_file
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/css/main.css")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_converts_the_index_dot_markdown_file_inside_source_to_html
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/index.html")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_converts_the_about_dot_markdown_file_to_html
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/pages/about.html")
    FileUtils::remove_dir(filename, true)
  end


  def test_it_converts_the_date_dash_welcome_to_hyde_file_to_html
    filename = "testfile"
    t=Time.new
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/posts/#{t.strftime("%F")}-welcome-to-hyde.html")
    FileUtils::remove_dir(filename, true)
  end
end
