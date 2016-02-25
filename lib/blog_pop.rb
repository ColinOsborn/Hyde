require 'erb'

class BlogPop

  include ERB::Util

  attr_accessor :builder

  def initialize
    @builder = SiteBuilder.new
    @date=Time.new.strftime("%F")

    # 2 - render the current item (by translating its markdown to HTML) --> make this some local variable in your method
    # 3 - use ERB to inject that rendered html into the layout -- pass it the binding of the method you're rendering _from_
  end

  def create_post(file_path, post_title)
    # 1 - read the layout file from source/layouts/default.html.erb into our template string
    body = builder.convert_to_html(file_path)
    render_html_with_template(file_path, body, post_title)
    # html_file_path = #markdown file located in correct directory
  end

  def render_html_with_template(file_path, body, post_title)
    erb_template = File.read("#{file_path}/source/layouts/default.html.erb")
    post_title_no_dash = post_title.gsub("-", " ")
    formatted_html = ERB.new(erb_template).result(binding)
    File.write("#{file_path}/_output/posts/#{@date}-#{post_title}.html", formatted_html)
  end
  #     so that it can access the stuff it needs to render the ERB
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

# puts output = renderer.result(list.get_binding)
