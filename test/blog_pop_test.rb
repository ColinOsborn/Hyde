gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'


require_relative '../lib/blog_pop'
require_relative '../lib/site_builder'
require_relative '../lib/file_manager'
require_relative '../lib/file_reader'

class BuildTest < MiniTest::Test

  attr_accessor :blog_pop
  attr_accessor :f
  attr_accessor :b
  attr_accessor :reader


  def setup
    @b = SiteBuilder.new
    @f = FileManager.new
    @blog_pop = BlogPop.new
    @reader = FileReader.new
  end

  def test_it_can_initialize_a_blop_populate_object
    assert b_local = BlogPop.new
  end

  def test_it_takes_a_filename_and_post_title_and_creates_a_new_post_with_todays_date
    filename = "testfile"
    post_title = "Crazy-Post"
    time = Time.new.strftime("%F")
    f.create_new_site_structure(filename)
    b.build(filename)
    blog_pop.create_post(filename, post_title)
    assert File.exist?(filename + "/_output/posts/#{time}-Crazy-Post.html")
    FileUtils::remove_dir(filename, true)
  end

  def test_it_creates_a_new_post_with_boilerplate_html_from_the_erb_file
    filename = "testfile"
    post_title = "Crazy-Post"
    time = Time.new.strftime("%F")
    f.create_new_site_structure(filename)
    b.build(filename)
    blog_pop.create_post(filename, post_title)
    content = reader.read(filename + "/_output/posts/#{time}-Crazy-Post.html")
    assert_equal content, "<!DOCTYPE html>\n<html>\n  <link rel=\"stylesheet\" type =\"text/css\" href=\"../css/main.css\" >\n  <head>\n    <meta charset=\"utf-8\">\n    <h1> Crazy Post </h1>\n  </head>\n  <body>\n      <p1>Your Content Here</p1>\n  </body>\n</html>\n"
    FileUtils::remove_dir(filename, true)
  end



end
