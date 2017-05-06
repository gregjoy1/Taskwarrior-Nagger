$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support/core_ext'
require 'taskwarrior-web/version'
require 'dotenv/load'

module TaskwarriorWeb
  autoload :App,            'taskwarrior-web/app'
  autoload :Helpers,        'taskwarrior-web/helpers'
  autoload :Task,           'taskwarrior-web/model/task'
  autoload :Annotation,     'taskwarrior-web/model/annotation'
  autoload :Config,         'taskwarrior-web/model/config'
  autoload :Command,        'taskwarrior-web/model/command'
  autoload :CommandBuilder, 'taskwarrior-web/services/builder'
  autoload :Runner,         'taskwarrior-web/services/runner'
  autoload :Parser,         'taskwarrior-web/services/parser'
  autoload :Nagger,         'taskwarrior-web/services/nagger'

  class UnrecognizedTaskVersion < Exception; end
end
