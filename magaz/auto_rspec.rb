require 'file-monitor'

dir = ARGV[0] || '.'

# watch current working directory
FileMonitor.watch dir do

  # set frequency 0.2 second (optional default is 0.2)
  # frequency 0.2

  # do not follow the symlink (optional default is false)
  # follow_symlink false


  # do not watch directory contains git and svn
  # the last charactor '/' has been trimmed
  dirs {
    disallow /git$/
  }

  # record ruby files only
  # it equals files /\.rb$/
  files {
    disallow /.*/
    allow /\.rb$/
    allow /\.slim$/
  }

  # The commands will be runned when file changed
  # the events contains all file modified infomation in last 0.2 second
  exec {|events|
    p '----------------------------   rspec runing...  ---------------------------------'
    system 'bundle exec rspec'
  }
end