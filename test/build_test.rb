gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'


require_relative '../lib/hyde'

class BuildTest < MiniTest::Test



  attr_accessor :f
  attr_accessor :b

  def setup
    @b = SiteBuilder.new
    @f = FileManager.new
  end

  def test_it_creates_a_new_SiteBuilder
    assert b1 = SiteBuilder.new
  end

  # def test_it_returns_an_error_if_it_is_given_new_for_a_directory_that_already_exists
  #   filename = "testfile"
  #   FileUtils::mkdir_p filename
  #   assert_equal "Error. Directory #{filename} already exists.",
  #                b.build(filename)
  #   FileUtils::remove_dir(filename, true)
  # end

  # def test_it_creates_the_project_at_the_given_file_path
  #   skip
  #   filename = "testfile"
  #   b.build(filename)
  #   assert Dir.exist?(filename)
  #   FileUtils::remove_dir(filename, true)
  # end

  # def test_it_creates_underscore_output_as_a_top_level_folder
  #   skip
  #   filename = "testfile"
  #   b.build(filename)
  #   assert Dir.exist?(filename + "/_output")
  #   FileUtils::remove_dir(filename, true)
  # end
  #
  # def test_it_creates__output_as_a_top_level_folder
  #   skip
  #   filename = "testfile"
  #   b.build(filename)
  #   assert Dir.exist?(filename + "/_output")
  #   FileUtils::remove_dir(filename, true)
  # end

  def test_inside__output_it_creates_a_css_folder
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/css")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside_source_it_creates_a_layouts_folder
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/layouts")
    FileUtils::remove_dir(filename, true)
  end



  def test_inside__output_it_creates_a_pages_folder
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/pages")
    FileUtils::remove_dir(filename, true)
  end

  def test_inside__output_it_creates_a_posts_folder
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert Dir.exist?(filename + "/_output/posts")
    FileUtils::remove_dir(filename, true)
  end


  #File Creation Tests
  #------------------
  def test_it_copies_the_main_dot_css_file
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/css/main.css")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_converts_the_index_dot_markdown_file_inside_source_to_html
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/index.html")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_converts_the_about_dot_markdown_file_to_html
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/pages/about.html")
    FileUtils::remove_dir(filename, true)
  end


  def test_it_converts_the_date_dash_welcome_to_hyde_file_to_html
    skip
    filename = "testfile"
    t=Time.new
    f.create_new_site_structure(filename)
    b.build(filename)
    assert File.exist?(filename + "/_output/posts/#{t.strftime("%F")}-welcome-to-hyde.html")
    FileUtils::remove_dir(filename, true)
  end

  #-----------------------------
  # Lets assume we're going to do the posts from inside SiteBuilder

  def test_it_takes_the_root_location_and_title_of_a_post_and_creates_a_new_post_in__output_posts_folder
    skip
    filename = "testfile"
    f.create_new_site_structure(filename)
    b.build(filename)

    b.post(title)
    t=Time.new
    assert File.exist?(filename + "/_output/posts/#{t.strftime("%F")}-post.html")
    FileUtils::remove_dir(filename, true)
  end

end
