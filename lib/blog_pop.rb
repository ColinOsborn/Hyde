require 'erb'

class BlogPop

  include ERB::Util

  attr_accessor :builder

  def initialize
    @builder = SiteBuilder.new
    @date=Time.new.strftime("%F")
  end

  def create_post(file_path, post_title)
    erb_template = File.read("#{file_path}/_output/layouts/default.html.erb")
    post_title_no_dash = post_title.gsub("-"," ")
    body = ERB.new(erb_template).result(binding)
    File.write("#{file_path}/_output/posts/#{@date}-#{post_title}.html", body)
  end
end


# 1 - read the layout file from source/layouts/default.html.erb into our template string
# 2 - render the current item (by translating its markdown to HTML) --> make this some local variable in your method
# 3 - use ERB to inject that rendered html into the layout -- pass it the binding of the method you're rendering _from_
