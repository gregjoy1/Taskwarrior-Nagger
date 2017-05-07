$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support/core_ext'
require 'dotenv/load'

module TaskwarriorNagger
  autoload :App,            'taskwarrior-nagger/app'
  autoload :Helpers,        'taskwarrior-nagger/helpers'
  autoload :Task,           'taskwarrior-nagger/model/task'
  autoload :Annotation,     'taskwarrior-nagger/model/annotation'
  autoload :Config,         'taskwarrior-nagger/model/config'
  autoload :Command,        'taskwarrior-nagger/model/command'
  autoload :CommandBuilder, 'taskwarrior-nagger/services/builder'
  autoload :Runner,         'taskwarrior-nagger/services/runner'
  autoload :Parser,         'taskwarrior-nagger/services/parser'
  autoload :Nagger,         'taskwarrior-nagger/services/nagger'

  class UnrecognizedTaskVersion < Exception; end
end
