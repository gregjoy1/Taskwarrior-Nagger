module TaskwarriorNagger::CommandBuilder
  autoload :Base, 'taskwarrior-nagger/services/builder/base'
  autoload :V1,   'taskwarrior-nagger/services/builder/v1'
  autoload :V2,   'taskwarrior-nagger/services/builder/v2'

  class InvalidCommandError < Exception; end
  class MissingTaskIDError < Exception; end

  def self.included(class_name)
    class_name.class_eval do
      case TaskwarriorNagger::Config.version.major
      when 2
        include TaskwarriorNagger::CommandBuilder::V2
      when 1
        include TaskwarriorNagger::CommandBuilder::V1
      else
        raise TaskwarriorNagger::UnrecognizedTaskVersion
      end
    end
  end

end
