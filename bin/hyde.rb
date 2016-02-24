class FileManager


  def create_new_site_structure(filename)
    if Dir.exist?(filename)
      puts "Error. Directory #{filename} already exists."
    else
      Dir.mkdir(filename)
      Dir.mkdir(filename + "/_output")
      Dir.mkdir(filename + "/source")
      make_basic_folders(filename + "/source")
      make_starting_files(filename + "/source")
    end
  end

  def make_basic_folders(filename)
    Dir.mkdir(filename + "/css")
    Dir.mkdir(filename + "/pages")
    Dir.mkdir(filename + "/posts")
  end

  def make_starting_files(filename)
    t = Time.new
    File.write(filename + "/css/main.css", "")
    File.write(filename + "/index.markdown", "")
    File.write(filename + "/pages/about.markdown", "")
    File.write(filename + "/posts/" + t.strftime("%F") + "-welcome-to-hyde.markdown", "")
  end




end

class Build

  def build_method(file_manager, filename)
    file_manager.make_basic_folders(filename)

  end

    # Create file structure in the output folder using FileManager

    # Call FileManager to populate files from source to outpu

    # Use FileManager to iterate through the files,
    #  # Processing Markdown and put resulting HTML in output


  end



if __FILE__ ==$0
  case ARGV[0]
  when nil
    puts "No command given"
  when "new"
    if ARGV[1] == nil
      puts "No filename given"
      # filename = gets
      # filename.chomp!
    else
      filename = ARGV[1]
    end
    f=FileManager.new
    f.create_new_site_structure(filename)
  end
end





  # if ARGV[0] == nil
  #   puts "No command given"
  # elsif ARGV[0] == "new"
  #
  #
  #
  # end
  # end



# args = ARGV
# puts "You ran Hyde with these arguments: #{args}"

# ##############
# Your code here
# ##############

#
# class Hyde
#  def initialize(method, location)
#   Dir.mkdir("method")
#   p "#{method}#{location}"
#  end
#
#
# end
