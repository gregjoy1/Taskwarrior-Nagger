#!/usr/bin/env ruby

require 'time'
require 'digest'
require 'pry'

class TaskwarriorNagger::App
  autoload :Helpers, 'taskwarrior-nagger/helpers'

  @@root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
  set :root,  @@root
  set :app_file, __FILE__
  set :method_override, true

  # Helpers
  helpers Helpers
end
