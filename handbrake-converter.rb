require 'rubygems'
require 'configatron'
require File.expand_path(File.dirname(__FILE__) + "/lib/choice.rb")
require 'pp'

#handbrake-converter.rb
PROGRAM_VERSION = 0.1

puts 'Lauching handbrake-converter.rb...'
puts ''

puts 'Loading configuration file...'
@@config = configatron.configure_from_yaml(File.expand_path(File.dirname(__FILE__) + "/config/config.yml"))
puts 'Configuration file loaded...'
puts ''

puts 'Scanning source directory...'
src_dir_contents = Dir.entries(Choice.choices[:source])
puts 'Source directory scanned...'
puts ''

puts "Processing files in the directory " + 
     Choice.choices[:source] + 
     " with extensions '" + 
     Choice.choices[:type] + 
     "' and putting them in destination directory " + 
     Choice.choices[:destination] + " ..."
puts ''

filetype_length = Choice.choices[:type].length

src_dir_contents.each do |movie_to_convert|
  filename_length = movie_to_convert.length
  if filename_length > filetype_length
    length_offset = movie_to_convert.length - filetype_length
    if movie_to_convert.slice(length_offset, filetype_length) == Choice.choices[:type]
      filename = movie_to_convert.split(".")
      movie_name = filename[0]
      if Choice.choices[:use_dvd] == true
        conversion_instruction = @@config["handbrakecli_location"] + 
                                 "/HandBrakeCLI -i DVD +
                                 " -o #{Choice.choices[:destination]}/#{movie_name}" + 
                                 @@config['handrake_presets'][Choice.choices[:conversion]]
      else
        conversion_instruction = @@config["handbrakecli_location"] + 
                                 "/HandBrakeCLI -i #{Choice.choices[:source]}/#{movie_to_convert}" +
                                 " -o #{Choice.choices[:destination]}/#{movie_name}" + 
                                 @@config['handrake_presets'][Choice.choices[:conversion]]
      end
      puts 'Starting to process file ' + movie_to_convert + '...'
      puts conversion_instruction
      system(conversion_instruction)
      if Choice.choices[:delete] == true
        system("rm #{Choice.choices[:source]}/#{movie_to_convert}")
      end
      puts 'Finished processing file ' + movie_to_convert + '...'
      puts ''
    end
  end
end

puts 'Completed conversions...'
