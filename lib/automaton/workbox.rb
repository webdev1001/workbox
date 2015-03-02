require 'dropbox_authorization.rb'
require 'helpers.rb'
require 'dropbox_sdk'

# Workbox class embodies all functions for creation of any folder structure.
# Folder structure must be given as an argument to 'create_and_print' function.
class Workbox
  include Helpers
  include DropboxAuthorization

  attr_reader :client, :root, :removed

  def initialize
    @client = set_client
    @root = create_root
    @removed = []
  end

  def create_and_print(folder_structure)
    create_structure(folder_structure)
    puts "\nBelow is the structure you created:\n\n"
    print_structure(folder_structure)
  end

  private

  def create_structure(folder_structure, path = @root)
    folder_structure.each do |folder|
      folder_name, new_path = add_path(folder, path)
      if obligatory?(folder_name)
        create_new_folder(folder, new_path)
      else
        optional_folder(folder, folder_name, new_path)
      end
    end
  end

  def create_root
    print 'Enter a name for your project -> '
    root = "/#{gets.chomp}"
    create_folder(root)
    root
  end

  def add_path(folder, path)
    folder_name = folder.is_a?(Hash) ? folder.first[0] : folder
    longer_path = path + folder_name
    [folder_name, longer_path]
  end

  def optional_folder(folder, folder_name, path)
    print "Do you need folder for #{clean_folder(folder_name)}? (y/n) -> "
    if validate(gets.chomp.downcase) == 'y'
      create_new_folder(folder, path)
    else
      @removed << folder_name
    end
  end

  def obligatory?(folder_name)
    folder_name[-1] != '*'
  end

  def create_new_folder(folder, path)
    path = clean(path)
    folder.is_a?(Hash) ? create_lower_level(folder, path) : create_folder(path)
  end

  def create_lower_level(folder, path)
    create_folder(path)
    lower_level = folder.first[1]
    create_structure(lower_level, path)
  end

  def create_folder(path)
    print "Creating '#{clean_folder(path.split('/').last)}' folder....."
    @client.file_create_folder(path)
    puts 'done.'
  end

  def clean_folder(name)
    name = name[1...name.size] if name[0] == '/'
    clean(name)
  end

  def clean(name)
    name[-1] == '*' ? name[0...name.size - 1] : name
  end

  def print_structure(structure, level = 0)
    structure.each_with_index do |folder, index|
      folder_name = folder.is_a?(Hash) ? folder.first[0] : folder
      next if @removed.include?(folder_name)
      puts "#{'--' * level}#{clean_folder(folder_name)}"
      if folder.is_a?(Hash)
        lower_struct = structure[index][folder_name]
        print_structure(lower_struct, level + 1)
      end
    end
  end
end
