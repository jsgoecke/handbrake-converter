require 'choice'

Choice.options do
  header ''
  header 'Specific options:'

  option :source do
    short '-s'
    long '--source=SOURCE'
    desc 'The full source directory to fetch the video files from'
    default '.'
  end

  option :use_dvd do
    short '-u'
    long '--use_dvd=USE_DVD'
    desc 'Use a DVD as the source as opposed to a directory'
    default false    
  end

  option :destination do
    short '-d'
    long '--destination=DESTINATION'
    desc 'The full destination directory to store the converted video files to'
    default '.'
  end
  
  option :conversion do
    short '-c'
    long '--conversion=CONVERSION'
    desc 'The conversion preset to use, see config/config.yml for options'
    default 'quicktime'
  end

  option :type do
    short '-t'
    long '--type=TYPE'
    desc 'The originating filetype to get from the source directory (ie - wmv, mov, avi)'
    default 'wmv'
  end
  
  option :delete do
    short '-d'
    long '--delete=DELETE'
    desc 'Set to true if you would like to delete the source file after conversion'
    default 'false'
  end
  
  separator ''
  separator 'Common options: '

  option :help do
    long '--help'
    desc 'Show this message'
  end

  option :version do
    short '-v'
    long '--version'
    desc 'Show version'
    action do
      puts "handbrake-converter.rb v#{PROGRAM_VERSION}"
      exit
    end
  end
end